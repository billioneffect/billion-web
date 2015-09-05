require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:competition).inverse_of(:projects) }
    it { is_expected.to have_many(:memberships).inverse_of(:project) }
    it { is_expected.to have_many(:collaborators).inverse_of(:projects) }
    it { is_expected.to have_many(:comments).inverse_of(:project) }
    it { is_expected.to have_many(:sent_transactions) }
    it { is_expected.to have_many(:received_transactions) }
    it do
      is_expected.to have_many(:comments)
        .inverse_of(:project)
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:collaborators)
        .through(:memberships)
        .source(:user)
    end

    it do
      is_expected.to have_many(:memberships)
        .inverse_of(:project)
        .dependent(:destroy)
    end
  end
end
