class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  after_action :verify_authorized, except: [:index, :insights, :calendar] , unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:index, :insights, :calendar], unless: :skip_pundit?

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
