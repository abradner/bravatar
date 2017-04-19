class User < ApplicationRecord
  has_secure_password
  has_many :user_emails,  autosave: true, dependent: :destroy
  has_one :primary_email, -> { where primary: true }, class_name: 'UserEmail'

  validate do
    errors.add(:base, "Email required") and next unless primary_email.present?
    errors.add(:base, primary_email.errors.to_a) unless primary_email.valid?
  end

  validates :name, presence: true

  def self.find_by_any_email(email)
    ue = UserEmail.find_by(email: email)
    return ue.user if ue.present?
  end

  def add_email(email, opts = {})
    primary = opts[:primary] || false # for clarity. logically zero sum
    if primary # if we're adding a new primary we need to demote the old one
      primary_email.primary = false # saving handled by 'autosave' property of :user_emails association
    end
    user_emails.build(email: email, primary: primary)
  end

end