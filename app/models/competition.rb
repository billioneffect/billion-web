class Competition < ActiveRecord::Base
  has_many :competition_features, inverse_of: :competition, dependent: :destroy
  has_many :product_features, through: :competition_features
  has_one :competition_config, inverse_of: :competition, dependent: :destroy
  has_many :projects, inverse_of: :competition, dependent: :destroy
  has_many :transactions, inverse_of: :competition, dependent: :destroy
  has_many :rounds, inverse_of: :competition, dependent: :destroy

  validates :competition_config, :code_name, :start_date, :end_date, presence: true
  validates :active, uniqueness: { conditions: -> { where(active: true) } }

  def self.current_competition
    find_by active: true
  end

  # TODO: spec
  def has_winner?
    projects.where(eliminated_at: nil).count == 1
  end

  def winner
    projects.find_by(eliminated_at: nil) if has_winner?
  end

  # TODO: determine active round via flag instead of start/end datetimes
  def active_round
    rounds.find_by('started_at < :now and ended_at > :now', now: Time.now)
  end

  def total_raised
    transactions.where('sender_id IS NULL').sum(:amount)
  end

  def has_feature?(feature)
    raise "Unrecognized feature #{feature}." if !ProductFeature::FEATURES.include?(feature.to_sym)

    self.product_features.exists?(name: feature.to_s)
  end
end
