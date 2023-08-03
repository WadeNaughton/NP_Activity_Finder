class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    if I18n.available_locales.include?(params[:locale]&.to_sym)
      I18n.locale = params[:locale]
    else
      redirect_to "/#{I18n.default_locale}"
    end
  end
end
