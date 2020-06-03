class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  after_action :verify_authorized, except: [:index, :insights, :calendar, :habits] , unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :insights, :calendar, :habits], unless: :skip_pundit?

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protect_from_forgery with: :exception

  # Starting action in config/routes.rb
  def welcome

    # Redirect to Google Authorization Page
    redirect_to GoogleCalendar.new.auth_uri

  end

  def token
    # Get a auth_client object from Google API
    @google_api = GoogleCalendar.new

    @google_api.auth_client.code = params[:code] if params[:code]
    response = @google_api.auth_client.fetch_access_token!

    session[:access_token] = response['access_token']

    # Whichever Controller/Action needed to handle what comes next
    redirect_to new_event_path()
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
