require 'rails_helper'

RSpec.describe UsersDepartmentsController, type: :controller do
  describe "#edit" do
    before do
      @admin_user = FactoryBot.create(:user, :admin)
      @department = FactoryBot.create(:department)
    end

    context "as an authorized user" do
      it "responds successfully" do
        sign_in @admin_user
        get :edit, params: { id: @department.id }
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        sign_in @admin_user
        get :edit, params: { id: @department.id }
        expect(response).to have_http_status "200"
      end
    end

    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
      end

      it "returns a 403 response" do
        sign_in @user
        get :edit, params: { id: @department.id }
        expect(response).to have_http_status "403"
      end
    end
  end

  describe "#update" do
    before do
      @other_user = FactoryBot.create(:user, :confirmed)
      @admin_user = FactoryBot.create(:user, :admin)
      @department = FactoryBot.create(:department)
    end

    context "as an authorized user" do
      it "returns a 302 response" do
        sign_in @admin_user
        patch :update, params: { id: @department.id, department:
                                { user_ids: [@other_user.id]} }
        expect(response).to have_http_status "302"
      end

      it "redirects to the department show page" do
        sign_in @admin_user
        patch :update, params: { id: @department.id, department:
                                { user_ids: [@other_user.id]} }
        expect(response).to redirect_to @department
      end
    end

    context "as an unauthorized user" do
      before do
        @other_user = FactoryBot.create(:user, :confirmed)
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
      end

      it "returns a 403 response" do
        sign_in @user
        patch :update, params: { id: @department.id, department:
                                { user_ids: [@other_user.id]} }
        expect(response).to have_http_status "403"
      end
    end
  end

  describe "#destroy" do
    before do
      @other_user = FactoryBot.create(:user, :confirmed)
      @admin_user = FactoryBot.create(:user, :admin)
      @department = FactoryBot.create(:department)
      @department.users << @other_user
    end

    context "as an authorized user" do
      it "returns a 303 response" do
        sign_in @admin_user
        delete :destroy, params: { id: @department.id, user_id: @other_user.id }
        expect(response).to have_http_status "303"
      end

      it "redirects to the department show page" do
        sign_in @admin_user
        delete :destroy, params: { id: @department.id, user_id: @other_user.id }
        expect(response).to redirect_to @department
      end
    end

    context "as an unauthorized user" do
      before do
        @other_user = FactoryBot.create(:user, :confirmed)
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
        @department.users << @other_user
      end

      it "returns a 403 response" do
        sign_in @user
        delete :destroy, params: { id: @department.id, user_id: @other_user.id }
        expect(response).to have_http_status "403"
      end
    end
  end
end
