module ApplicationHelper
  def flash_div_class(flash_type)
    {
      :success => 'alert-success',
      :error => 'alert-danger',
      :alert => 'alert-warning',
      :notice => 'alert-info'
    }.fetch(flash_type.to_sym, 'alert-info')
  end

  def flash_icon_class(flash_type)
    {
      :success => 'pficon-ok',
      :error => 'pficon-error-circle-o',
      :alert => 'pficon-warning-triangle-o',
      :notice => 'pficon-info'
    }.fetch(flash_type.to_sym, 'question-sign')
  end
end
