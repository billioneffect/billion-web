require 'rails_helper'

RSpec.describe Competition, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:code_name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:projects).inverse_of(:competition) }
  end
end
