class SmsVotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_temp_user
  before_action :set_project

  def create
    Rails.logger.debug "Vote controller params: #{params.inspect}"
    head :no_content
  end

  private

  def set_temp_user
    @temp_user = TempUser.find_or_create_by! phone: params[:From]
  rescue ActiveRecord::RecordInvalid => exception
    errors = exception.record.errors.full_messages
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def set_project
    @project = @competition.projects.find_by! sms_code: params[:Body]
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Project not found"] }, status: :not_found
  end
end
