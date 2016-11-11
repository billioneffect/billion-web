class TempUser < ActiveRecord::Base
  has_many :sent_transactions, as: :sender, class_name: 'Transaction'
  has_many :received_transactions, as: :recipient, class_name: 'Transaction'

  validates :email, email: true, allow_blank: true
  validates :phone, phone: { possible: true, allow_blank: true }

  with_options unless: :in_person? do |web_user|
    web_user.validates :email, presence: true, if: 'phone.blank?'
    web_user.validates :phone, presence: true, if: 'email.blank?'
  end

  accepts_nested_attributes_for :sent_transactions
end
