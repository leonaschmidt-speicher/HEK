class ApplicationController < ActionController::Base
  USERS = { 'zilly' => 'hekHL!611', 'sabrina' => 'pfaw03', 'dominik' => 'wz3ne2', 'joerg' => 'häppy!', 'clemens' => 'ab28y!' }

  protect_from_forgery

private
  def authenticate
    authenticate_or_request_with_http_basic {|user, password| @user = user if USERS[user] == password}
  end
end
