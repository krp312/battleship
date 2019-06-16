class ApplicationController < ActionController::Base
  def current_user
    cookies[:player].to_i
  end
end
