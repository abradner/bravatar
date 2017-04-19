class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    email = params[:email]

    existing = User.find_by_any_email(email)
    do_error(:bad_request, "A user with email #{email} already exists") && return if existing

    u = User.new(
      name: params[:name],
      primary_email: UserEmail.new(
        email: params[:email],
        primary: true
      ),
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    do_error(:bad_request, u.errors) && return unless u.valid?

    u.save

    command = AuthenticateUser.call(params[:email], params[:password]) # TODO Dry
    render json: { auth_token: command.result }

  rescue StandardError => e
    do_500 'user creation', e
  end
end
