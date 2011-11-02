class ApplicationController < ActionController::Base
  USERS = { 'simon' => 'pw', 'hannes' => 'p2' }

  protect_from_forgery

private
  def authenticate
    u = ''
    if authenticate_with_http_basic {|user, password| USERS[user] == password; u = user }
      @user = u
    else
      request_http_basic_authentication
    end
  end
end
