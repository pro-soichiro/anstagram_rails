# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PostsController, type: :controller do
  describe '#index' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'responds successfully' do
        sign_in @user
        get :index, params: { user_id: @user.id }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        get :index, params: { user_id: @user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'return a 302 response' do
        get :index, params: { user_id: @user.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :index, params: { user_id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#new' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'responds successfully' do
        sign_in @user
        get :new, params: { user_id: @user.id }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        get :new, params: { user_id: @user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'return a 302 response' do
        get :new, params: { user_id: @user.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :new, params: { user_id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#create' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'responds successfully' do
        sign_in @user
        post :create, format: :turbo_stream, params: { user_id: @user.id,
                                                       post: FactoryBot.attributes_for(:post) }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        post :create, format: :turbo_stream, params: { user_id: @user.id,
                                                       post: FactoryBot.attributes_for(:post) }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'return a 302 response' do
        post :create, format: :turbo_stream, params: { user_id: @user.id,
                                                       post: FactoryBot.attributes_for(:post) }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        post :create, format: :turbo_stream, params: { user_id: @user.id,
                                                       post: FactoryBot.attributes_for(:post) }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @post = FactoryBot.create(:post, user: @user)
      end

      it 'returns a 200 response' do
        sign_in @user
        delete :destroy, format: :turbo_stream,
                         params: { user_id: @user.id, id: @post.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @post = FactoryBot.create(:post, user: @user)
      end

      it 'return a 302 response' do
        delete :destroy, format: :turbo_stream,
                         params: { user_id: @user.id, id: @post.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        delete :destroy, format: :turbo_stream,
                         params: { user_id: @user.id, id: @post.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
