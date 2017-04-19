require 'rails_helper'

RSpec.describe User, type: :model do
  it 'allows users to have one email' do
    u = User.create!(primary_email: UserEmail.new(email: 'hello@hooli.xyz', primary: true), password: 'blah', name: 'me')
    expect(u.primary_email.email).to eq 'hello@hooli.xyz'
  end

  it 'allows users to have multiple emails' do
    u = User.create!(primary_email: UserEmail.new(email: 'hello@hooli.xyz', primary: true), password: 'blah', name: 'me')
    u.add_email 'abc@hooli.xyz'
    u.save

    expect(u.primary_email.email).to eq 'hello@hooli.xyz'
    expect(u.user_emails.count).to eq 2
    expect(u.user_emails.first.email).to eq 'hello@hooli.xyz'
    expect(u.user_emails.last.email).to eq 'abc@hooli.xyz'

  end

  it 'forces users to have at least one email' do
    u = User.new(password: 'blah', name: 'me')
    expect(u).to_not be_valid

    u.primary_email = UserEmail.new(email: 'hello@hooli.xyz', primary: true)

    expect(u).to be_valid
  end

  it 'lets a user log in via any email'
end
