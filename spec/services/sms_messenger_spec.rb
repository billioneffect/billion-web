require 'rails_helper'

describe SMSMessenger do
  describe '#send_message' do
    it 'sends sms via client' do
      messenger = SMSMessenger.new

      messenger.send_message(
        to: '1112221111',
        body: 'hello'
      )

      messages = SMSMessenger.client.messages
      expect(messages.last.body).to eq('hello')
    end
  end
end
