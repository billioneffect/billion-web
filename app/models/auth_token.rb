class AuthToken < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  before_create :set_token
  after_create :set_expires_at

  private

  def set_token
    self.token = SecureRandom.uuid
  end

  def set_expires_at
    self.expires_at = created_at + 2.weeks
  end
end
