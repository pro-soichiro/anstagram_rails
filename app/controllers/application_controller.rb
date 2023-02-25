class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

    def auth_admin
      unless current_user.admin?
        render 'errors/forbidden', status: :forbidden
      end
    end
end
