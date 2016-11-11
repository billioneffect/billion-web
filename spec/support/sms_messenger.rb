RSpec.configure do |config|
  config.before :each, type: :feature do
    SMSMessenger.client.messages = []
  end
end
