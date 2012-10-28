class ApplicationController < ActionController::Base
  USERS = { 'zilly' => 'hekHL!611', 'mira' => 'ne47', 'jonas' => 'zg65', 'joerg' => 'happi!', 'pauline' => 'ab28y!', 'matthias' => '/Isj12Ba', 'judith' => '()ju90JU' }

  protect_from_forgery

private
  def authenticate
    authenticate_or_request_with_http_basic {|user, password| @user = user if USERS[user] == password}
  end
end
