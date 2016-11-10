class SmsVotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Rails.logger.debug "Vote controller params: #{params.inspect}"
    head :no_content
  end
end
