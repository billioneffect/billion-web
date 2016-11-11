class SmsVotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_temp_user
  before_action :set_project

  def create
    Transaction.create!(
      competition: @competition,
      recipient: @project,
      sender: @temp_user,
      points: 1
    )

    messenger.send_message(
      to: @temp_user.phone,
      body: "Thank you for voting for #{@project.name} for Startup Weekend's "\
      "People's Choice Award!"
    )

    render json: {}, status: :created
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
    messenger.send_message(
      to: @temp_user.phone,
      body: "\"#{params[:Body]}\" is not a valid code. Please resubmit!"
    )

    render json: { errors: ["Project not found"] }, status: :not_found
  end

  def messenger
    @messenger ||= SMSMessenger.new
  end
end
