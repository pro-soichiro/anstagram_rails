# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe '#create' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @post = FactoryBot.create(:post)
      end

      it 'responds successfully' do
        sign_in @user
        post :create, format: :turbo_stream, params: { id: @post.id }
        expect(response).to be_successful
      end

      it 'returns a 201 response' do
        sign_in @user
        post :create, format: :turbo_stream, params: { id: @post.id }
        expect(response).to have_http_status '201'
      end
    end

    context 'as a guest' do
      before do
        @post = FactoryBot.create(:post)
      end

      it 'return a 302 response' do
        post :create, format: :turbo_stream, params: { id: @post.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        post :create, format: :turbo_stream, params: { id: @post.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#destroy' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @post = FactoryBot.create(:post)
        @user.likes_posts << @post
      end

      it 'returns a 303 response' do
        sign_in @user
        delete :destroy, format: :turbo_stream, params: { id: @post.id }
        expect(response).to have_http_status '303'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
        @post = FactoryBot.create(:post)
        @user.likes_posts << @post
      end

      it 'return a 302 response' do
        delete :destroy, format: :turbo_stream, params: { id: @post.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        delete :destroy, format: :turbo_stream, params: { id: @post.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
