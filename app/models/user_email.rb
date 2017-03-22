class UserEmail < ApplicationRecord
  belongs_to :user

  validates :primary, uniqueness: { scope: :user_id, message: 'A user can only have one primary email', if: :primary}
  validates :email, uniqueness: true
  
end
