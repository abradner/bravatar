class UserEmail < ApplicationRecord
  belongs_to :user, optional: true #optional only so we can create a user and a user email at the same time

  validates :primary, uniqueness: { scope: :user_id, message: 'A user can only have one primary email', if: :primary}
  validates :email, uniqueness: true
  validates :email, presence: true
  

end
