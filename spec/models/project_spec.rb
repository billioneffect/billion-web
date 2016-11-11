require 'rails_helper'

describe Project, type: :model do
  subject { build :project }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:sms_code).scoped_to(:competition_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:competition).inverse_of(:projects) }
    it { is_expected.to have_many(:sent_transactions).class_name('Transaction') }

    it do
      is_expected.to have_many(:received_transactions)
        .class_name('Transaction')
    end

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

    it do
      is_expected.to have_many(:matches_as_1)
        .class_name('Match')
        .with_foreign_key('project_1_id')
        .inverse_of(:project_1)
    end

    it do
      is_expected.to have_many(:matches_as_2)
        .class_name('Match')
        .with_foreign_key('project_2_id')
        .inverse_of(:project_2)
    end
  end

  describe '#current_competitor' do
    context 'there is current competitor' do
      it 'returns the current competitor' do
        competition = create :competition
        project = create :project, competition: competition
        competitor = create :project, competition: competition
        round = create :active_round, competition: competition
        create :match, round: round, project_1: project, project_2: competitor

        expect(project.current_competitor).to eq(competitor)
      end
    end

    context 'there is not a current competitor' do
      it 'returns nil' do
        competition = create :competition
        project = create :project, competition: competition
        competitor = create :project, competition: competition
        round = create :inactive_round, competition: competition
        create :match, round: round, project_1: project, project_2: competitor

        expect(project.current_competitor).to be_nil
      end
    end
  end

  describe '#points_donated' do
    it 'returns the total points donated to a project' do
      project = create :project

      create :transaction, recipient: project, points: 100
      create :transaction, recipient: project, points: 20
      create :transaction, sender: project, points: 50

      expect(project.points_donated).to eq(120)
    end
  end

  describe '#donation_count' do
    it 'returns the total number of donations to a project' do
      project = create :project

      create :transaction, recipient: project
      create :transaction, sender: project

      expect(project.donation_count).to eq(1)
    end
  end

  describe '#points_per_donation' do
    it 'returns the average number of points per donation' do
      project = create :project

      create :transaction, recipient: project, points: 10
      create :transaction, recipient: project, points: 20
      create :transaction, sender: project, points: 10

      expect(project.points_per_donation).to eq(15)
    end

    it 'protects against divide by zero' do
      project = create :project
      expect(project.points_per_donation).to eq(0)
    end
  end

  describe '#eliminated?' do
    it 'is eliminated if has eliminated_at' do
      project = create :project, eliminated_at: DateTime.now
      expect(project).to be_eliminated
    end

    it 'is not eliminated if eliminated_at is not present' do
      project = create :project, eliminated_at: nil
      expect(project).not_to be_eliminated
    end
  end
end
