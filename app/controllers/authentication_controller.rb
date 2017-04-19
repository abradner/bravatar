class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      do_error :unauthorized, command.errors
    end
  rescue StandardError => e
    do_500 'user creation', e
  end
end
