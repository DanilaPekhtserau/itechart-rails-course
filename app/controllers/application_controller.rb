# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def user_logged_in?
    !current_user.nil?
  end

  def redirect_to_sign_up
    redirect_to new_user_registration_path unless user_logged_in?
  end
end
