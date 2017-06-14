class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_env

  def set_current_env
    current_env
  end

  def current_env
    @current_env ||= CurrentEnv.from_session_and_request(session, request)
  end
end
