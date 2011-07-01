module ApplicationHelper
  def localize_time_strings(time)
    locale_time = I18n.localize(Chronic.parse(time)) 
  end
end
