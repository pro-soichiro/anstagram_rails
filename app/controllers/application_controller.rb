# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def auth_admin
    return if current_user.admin?

    render 'errors/forbidden', status: :forbidden
  end
end
