class Comment < ActiveRecord::Base
  belongs_to :project, inverse_of: :comments

  validates :author, :content, :project, presence: true
end
