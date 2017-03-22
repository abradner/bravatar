class User < ApplicationRecord
  has_secure_password
  has_many :user_emails,  autosave: true
  has_one :primary_email, -> { where primary: true }, class_name: 'UserEmail'

  validates :primary_email, presence: true

  def add_email(email, opts = {})
    primary = opts[:primary] || false # for clarity. logically zero sum
    if primary # if we're adding a new primary we need to demote the old one
      primary_email.primary = false # saving handled by 'autosave' property of :user_emails association
    end
    user_emails.build(email: email, primary: primary)
  end

end
