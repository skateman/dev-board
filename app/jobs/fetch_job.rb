class FetchJob < ApplicationJob
  queue_as :default

  CONFIG = Rails.application.secrets.github

  def perform
    repository = CONFIG['repository']

    result = client.pulls(repository).map do |pull|
      labels = client.labels_for_issue(repository, pull[:number]).map do |label|
        {
          :name  => label[:name],
          :color => "##{label[:color]}",
          :text  => label[:color].scan(/[a-f0-9]{2}/i).map(&:hex).sum > 600 ? 'black' : 'white'
        }
      end

      mergeable = true
      wip = false

      labels.reject! do |label|
        case label[:name]
        when 'unmergeable'
          mergeable = false
          true
        when 'wip'
          wip = true
          true
        end
      end

      {
        :user    => pull[:user][:login],
        :title   => pull[:title].gsub(/\[WIP\]/i, '').strip,
        :number  => pull[:number],
        :labels  => labels,
        :merge   => mergeable,
        :wip     => wip,
        :status  => client.combined_status(repository, pull[:head][:sha])[:state],
        :assign  => pull[:assignee].try(:[], :login),
        :created => pull[:created_at],
        :updated => pull[:updated_at]
      }
    end

    Sidekiq.redis { |conn| conn.set(:result, result.to_json) }
  end

  after_perform do
    self.class.set(:wait => 5.minutes).perform_later
  end

  def client
    return Octokit if CONFIG['username'].nil? || CONFIG['password'].nil?

    @client ||= Octokit::Client.new(
      :login         => CONFIG['username'],
      :password      => CONFIG['password'],
      :auto_paginate => true
    )
  end
end
