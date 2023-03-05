require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  describe '#index' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'responds successfully' do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      it 'return a 302 response' do
        get :index
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#show' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
      end

      it 'responds successfully' do
        sign_in @user
        get :show, params: { id: @department.id }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        get :show, params: { id: @department.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @department = FactoryBot.create(:department)
      end

      it 'returns a 302 response' do
        get :show, params: { id: @department.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :show, params: { id: @department.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#new' do
    context 'as an authorized user' do
      before do
        @admin_user = FactoryBot.create(:user, :admin)
      end

      it 'responds successfully' do
        sign_in @admin_user
        get :new
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @admin_user
        get :new
        expect(response).to have_http_status '200'
      end
    end

    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'returns a 403 response' do
        sign_in @user
        get :new
        expect(response).to have_http_status '403'
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      before do
        @admin_user = FactoryBot.create(:user, :admin)
      end

      it 'returns a 302 response' do
        sign_in @admin_user
        post :create, params: { department: FactoryBot.attributes_for(:department) }
        expect(response).to have_http_status '302'
      end
    end

    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'returns a 403 response' do
        sign_in @user
        post :create, params: { department: FactoryBot.attributes_for(:department) }
        expect(response).to have_http_status '403'
      end
    end
  end

  describe '#edit' do
    context 'as an authorized user' do
      before do
        @admin_user = FactoryBot.create(:user, :admin)
        @department = FactoryBot.create(:department)
      end

      it 'responds successfully' do
        sign_in @admin_user
        get :edit, params: { id: @department.id }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @admin_user
        get :edit, params: { id: @department.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
      end

      it 'returns a 403 response' do
        sign_in @user
        get :edit, params: { id: @department.id }
        expect(response).to have_http_status '403'
      end
    end
  end

  describe '#update' do
    context 'as an authorized user' do
      before do
        @admin_user = FactoryBot.create(:user, :admin)
        @department = FactoryBot.create(:department)
      end

      it 'returns a 302 response' do
        sign_in @admin_user
        patch :update, params: { id: @department.id,
                                 department: FactoryBot.attributes_for(:department) }
        expect(response).to have_http_status '302'
      end
    end

    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
      end

      it 'returns a 403 response' do
        sign_in @user
        patch :update, params: { id: @department.id,
                                 department: FactoryBot.attributes_for(:department) }
        expect(response).to have_http_status '403'
      end
    end
  end

  describe '#destroy' do
    context 'as an authorized user' do
      before do
        @admin_user = FactoryBot.create(:user, :admin)
        @department = FactoryBot.create(:department)
      end

      it 'returns a 303 response' do
        sign_in @admin_user
        delete :destroy, params: { id: @department.id }
        expect(response).to have_http_status '303'
      end
    end

    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @department = FactoryBot.create(:department)
      end

      it 'returns a 403 response' do
        sign_in @user
        delete :destroy, params: { id: @department.id }
        expect(response).to have_http_status '403'
      end
    end
  end
end
