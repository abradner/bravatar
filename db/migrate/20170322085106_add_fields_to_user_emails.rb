class AddFieldsToUserEmails < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_emails, :user, foreign_key: true
    add_column :user_emails, :email, :string
    add_column :user_emails, :primary, :boolean
  end
end
