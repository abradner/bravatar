require 'rails_helper'

RSpec.describe UserEmail, type: :model do
  it 'does not allow one email to be associated with multiple accounts' do
    u1 = User.create!(primary_email: UserEmail.new(email: 'hello@hooli.xyz', primary: true), password: 'blah', name: 'me')
    u2 = User.new(primary_email: UserEmail.new(email: 'hello@hooli.xyz', primary: true), password: 'blah', name: 'me')

    expect(u2.primary_email).to_not be_valid
  end
  it 'requires an email' do
    u1 = User.create!(primary_email: UserEmail.new(email: 'hello@hooli.xyz', primary: true), password: 'blah', name: 'me')   

    ue = UserEmail.new(user: u1)
    expect(ue).to_not be_valid

    ue.email = 'me@me.me'
    expect(ue).to be_valid
  end

  it 'you can only have one primary email per user' do
    u = User.create!(primary_email: UserEmail.new(email: 'hello@hooli.xyz', primary: true), password: 'blah', name: 'me')

    new_email = u.user_emails.create! email: 'abc@hooli.xyz', primary: false
    expect(new_email).to be_valid

    new_email.primary = true
    expect(new_email).to_not be_valid
  end

end
