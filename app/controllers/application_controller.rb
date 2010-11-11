class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale

  private

  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      cookies[:locale] = { :value => I18n.locale, :expires => 10.years.from_now }
    else
      if cookies[:locale]
        I18n.locale = cookies[:locale]
      else
        locale = extract_locale_from_accept_language_header
        langs = ['cat', 'da', 'de', 'en', 'es', 'eus', 'fr', 'gr', 'it']
        if langs.include?(locale)
          I18n.locale = locale
        end
        cookies[:locale] = { :value => I18n.locale, :expires => 10.years.from_now }
      end
    end
  end

  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE']
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end
end
