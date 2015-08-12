require 'rails_helper'

describe User, type: :model do
  subject { build :user }

  describe 'validations' do
    it { is_expected.to have_attached_file(:profile_image) }

    it do
      is_expected.to validate_attachment_content_type(:profile_image)
        .allowing('image/jpeg', 'image/png', 'image/gif')
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:role).inverse_of(:users) }
  end

  describe '#admin?' do
    let(:admin) { build :admin }
    let(:user) { build :user }

    it 'is true for admin' do
      expect(admin).to be_admin
    end

    it 'is false for user' do
      expect(user).not_to be_admin
    end
  end
end
