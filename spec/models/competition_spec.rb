require 'rails_helper'

describe Competition, type: :model do
  # TODO: Add validations to ensure only 1 competition per time period
  describe 'validations' do
    it { should validate_presence_of(:competition_config) }
    it { should validate_presence_of(:code_name) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }

    describe 'active' do
      it 'allows many inactive competitions' do
        create :competition, active: false
        competiton = build :competition, active: false
        expect(competiton.valid?).to eq(true)
      end

      it 'allows only one active competition' do
        create :competition, active: true
        competiton = build :competition, active: true
        expect(competiton.valid?).to eq(false)
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:competition_features).inverse_of(:competition) }
    it { is_expected.to have_many(:product_features).through(:competition_features) }
    it { is_expected.to have_one(:competition_config).inverse_of(:competition) }

    it do
      is_expected.to have_many(:projects)
        .inverse_of(:competition)
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:transactions)
        .inverse_of(:competition)
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:rounds)
        .inverse_of(:competition)
        .dependent(:destroy)
    end
  end

  describe '#total_raised' do
    it 'returns the total funds raised' do
      competition = create :competition
      create :transaction, sender: nil, competition: competition, amount: 10.00
      create :transaction, sender: nil, competition: competition, amount: 20.00
      create :transaction, sender: nil, competition: competition, amount: 30.00
      create :transaction, competition: competition, amount: 40.00

      expect(competition.total_raised).to eq(60.00)
    end
  end

  describe '#active_round' do
    context 'with active round' do
      it 'returns the active round' do
        competition = create :competition
        active_round = create :active_round, competition: competition
        create :inactive_round, competition: competition

        expect(competition.active_round).to eq(active_round)
      end
    end

    context 'with no active round' do
      it 'returns nil' do
        competition = create :competition
        create :inactive_round, competition: competition

        expect(competition.active_round).to be_nil
      end
    end
  end

  describe '#has_feature?' do
    it 'raises an error with invalid feature' do
      competition = build :competition
      expect { competition.has_feature?(:bad) }.to raise_error
    end

    it 'returns true if the competition has the feature' do
      feature = create :product_feature, name: ProductFeature::FEATURES.first

      competition = build :competition
      competition.product_features << feature
      competition.save

      expect(competition).to have_feature(feature.name)
    end

    it 'returns false if the competition does not have the feature' do
      feature = create :product_feature, name: ProductFeature::FEATURES.first
      competition = create :competition
      expect(competition).not_to have_feature(feature.name)
    end
  end

  describe '.current_competition' do
    context 'there is a current competition' do
      it 'returns the current competition' do
        create :competition, active: false
        current_competition = create :competition, active: true

        expect(Competition.current_competition).to eq(current_competition)
      end
    end

    context 'there is no current competition' do
      it 'returns nil' do
        expect(Competition.current_competition).to be_nil
      end
    end
  end
end
