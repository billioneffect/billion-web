class SMSMessenger
  cattr_accessor :client
  self.client = Twilio::REST::Client

  def initialize
    @client = self.class.client.new(
      ENV['twilio_account_sid'],
      ENV['twilio_auth_token']
    )
  end

  def send_message(to:, body:)
    @client.messages.create(to: to, from: ENV['twilio_from_number'], body: body)
  end
end
