require 'rails_helper'

describe Payment do
  describe '.pay' do
    it 'returns true if nonce is valid' do
      expect(Payment.new('fake-valid-nonce', 2).pay).to eql(true)
    end

    it 'returns false if client token was already consumed' do
      expect(Payment.new('fake-consumed-nonce', 2).pay).to eql(false)
    end

    it 'sets the errors messages' do
      payment = Payment.new('fake-consumed-nonce', 2)
      payment.pay
      expect(payment.errors).not_to be_empty
    end

    # these exceptions take one optional argument
    [
      Braintree::AuthenticationError,
      Braintree::AuthorizationError,
      Braintree::DownForMaintenanceError,
      Braintree::ForgedQueryString,
      Braintree::InvalidChallenge,
      Braintree::InvalidSignature,
      Braintree::NotFoundError,
      Braintree::ServerError,
      Braintree::SSLCertificateError,
      Braintree::UnexpectedError,
      Braintree::UpgradeRequiredError
    ].each do |braintree_error|
      it "raises PaymentServiceError when Braintree encounter a #{braintree_error.name}" do
        nonce = 'fake-valid-nonce'
        amount = 2
        expect(Braintree::Transaction).to receive(:sale)
          .with(payment_method_nonce: nonce, amount: amount)
          .and_raise(braintree_error)
        expect { Payment.new(nonce, amount).pay }.to raise_error(Payment::PaymentServiceError)
      end
    end

    # separate test from loop because ConfigurationError takes two arguments
    it 'raises PaymentServiceError when Braintree encounter a Braintree::ConfigurationError' do
      nonce = 'fake-valid-nonce'
      amount = 2
      expect(Braintree::Transaction).to receive(:sale)
        .with(payment_method_nonce: nonce, amount: amount)
        .and_raise(Braintree::ConfigurationError.new('setting', 'message'))
      expect { Payment.new(nonce, amount).pay }.to raise_error(Payment::PaymentServiceError)
    end
  end
end
