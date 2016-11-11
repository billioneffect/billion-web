require 'rails_helper'

describe TempUser, type: :model do
  subject { build :temp_user }

  describe 'validations' do
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value(Faker::Lorem.word).for(:email) }

    it { is_expected.not_to allow_value(Faker::Lorem.word).for(:phone) }
    %w(8326607469 832.660.7469 832-660-7469 18326607469 +18326607469).each do |phone|
      it { is_expected.to allow_value(phone).for(:phone) }
    end

    context 'in person temp user' do
      subject { build :temp_user, :in_person }

      it { is_expected.to allow_value(nil).for(:email) }
      it { is_expected.to allow_value('').for(:email) }
    end

    context 'on web temp user' do
      subject { build :temp_user, :on_web }

      it { is_expected.to_not allow_value(nil).for(:email) }
      it { is_expected.to_not allow_value('').for(:email) }

      it 'requires email if phone is not present' do
        temp_user = build :temp_user, in_person: false, phone: nil
        expect(temp_user).to_not allow_value(nil).for(:email)
      end

      it 'requires phone if email is not present' do
        temp_user = build :temp_user, in_person: false, email: nil
        expect(temp_user).to_not allow_value(nil).for(:phone)
      end

      it 'allows nil for phone if email is present' do
        temp_user = build :temp_user, in_person: false, email: Faker::Internet.email
        expect(temp_user).to allow_value(nil).for(:phone)
      end

      it 'allows nil for email if phone is present' do
        temp_user = build :temp_user, in_person: false, phone: Faker::PhoneNumber.phone_number
        expect(temp_user).to allow_value(nil).for(:email)
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:sent_transactions) }
    it { is_expected.to have_many(:received_transactions) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:sent_transactions) }
  end

  describe 'defaults' do
    its(:in_person) { is_expected.to eq(false) }
  end
end
