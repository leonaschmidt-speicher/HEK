class ApplicationController < ActionController::Base
  USERS = { 'zilly' => 'hekHL!611', 'mira' => 'ne47', 'jonas' => 'zg65', 'joerg' => 'happi!', 'clemens' => 'ab28y!' }

  protect_from_forgery

private
  def authenticate
    authenticate_or_request_with_http_basic {|user, password| @user = user if USERS[user] == password}
  end
end
