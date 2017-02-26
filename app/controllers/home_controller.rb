class HomeController < ApplicationController
  def index
    @results = Sidekiq.redis { |x| JSON.parse(x.get('result')) }
    @repo = Rails.application.secrets.github['repository']
  rescue Redis::CannotConnectError
    flash[:error] = 'Cannot connect to the Redis server!'
  rescue TypeError
    flash[:error] = 'No data in the database, check if Sidekiq is running!'
  end
end
