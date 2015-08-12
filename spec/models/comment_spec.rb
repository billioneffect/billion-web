require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:project) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project).inverse_of(:comments) }
  end
end
