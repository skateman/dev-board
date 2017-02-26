module HomeHelper
  def status_icon_class(status)
    case status
    when 'success', true
      'pficon-ok'
    when 'failure', false
      'pficon-error-circle-o'
    else
      'pficon-warning-triangle-o'
    end
  end

  def bool_icon_class(bool)
    bool ? 'pficon-ok' : 'pficon-error-circle-o'
  end

  def time_ago(time)
    time_ago_in_words(time).sub('about ', '')
  end
end
