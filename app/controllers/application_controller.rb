class ApplicationController < ActionController::Base
  include Pundit
  helper MetaTagHelpers
  helper VoteButtonHelpers
  helper ProgressBarHelpers
  helper LandingCardLayoutHelpers
  before_action :set_competition

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def set_competition
    @competition = Competition.current_competition
  end
end
