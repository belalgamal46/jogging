class ApplicationController < ActionController::API
  def date_safe_parse(value, default = nil)
    Date.parse(value.to_s)
  rescue ArgumentError
    default
  end
end
