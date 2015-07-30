class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :timeoutable, :recoverable,
    :rememberable, :trackable, :validatable, :lockable

  belongs_to :role, inverse_of: :users

  def admin?
    return self.role_id == 2
  end
end
