# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
      end

      it 'responds successfully' do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        get :show, params: { id: @user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'returns a 302 response' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#update' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'responds successfully' do
        user_params = FactoryBot.attributes_for(:user,
                                                avatar: Rack::Test::UploadedFile.new(
                                                  Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg'
                                                ))
        sign_in @user
        patch :update, params: { id: @user.id, user: user_params }
        expect(@user.reload.avatar.attached?).to be_truthy
      end

      it 'returns a 200 response' do
        user_params = FactoryBot.attributes_for(:user,
                                                avatar: Rack::Test::UploadedFile.new(
                                                  Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg'
                                                ))
        sign_in @user
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to @user
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'returns a 302 response' do
        user_params = FactoryBot.attributes_for(:user,
                                                avatar: Rack::Test::UploadedFile.new(
                                                  Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg'
                                                ))
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        user_params = FactoryBot.attributes_for(:user,
                                                avatar: Rack::Test::UploadedFile.new(
                                                  Rails.root.join('spec/files/attachment.jpg'), 'image/jpeg'
                                                ))
        patch :update, params: { id: @user.id, user: user_params }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    context 'as an authorized user' do
      before do
        @other_user = FactoryBot.create(:user)
        @admin_user = FactoryBot.create(:user, :admin)
      end

      it 'returns a 303 response' do
        sign_in @admin_user
        delete :destroy, params: { id: @other_user.id }
        expect(response).to have_http_status '303'
      end
    end

    context 'as an unauthorized user' do
      before do
        @other_user = FactoryBot.create(:user)
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'returns a 403 response' do
        sign_in @user
        delete :destroy, params: { id: @other_user.id }
        expect(response).to have_http_status '403'
      end
    end
  end
end
