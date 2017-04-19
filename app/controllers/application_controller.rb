class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  def do_error(code, message)
    render json: { error: message }, status: code
  end
  
  def do_500(action, exception)
    render json: { 
      error: "#{action} failed",
      message: exception.message,
      backtrace: exception.backtrace
    }, 
    status: :internal_server_error
  end
    
  
  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    do_error :unauthorized, 'Not Authorized' unless @current_user
  end

end
