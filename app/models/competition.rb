class Competition < ActiveRecord::Base
  has_many :projects, inverse_of: :competition, dependent: :destroy

  validates :code_name, :start_date, :end_date, presence: true
  # TODO: validate that end_date > start_date
end
