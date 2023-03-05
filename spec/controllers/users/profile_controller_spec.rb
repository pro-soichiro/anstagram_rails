# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ProfileController, type: :controller do
  describe '#edit' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'responds successfully' do
        sign_in @user
        get :edit, params: { user_id: @user.id }
        expect(response).to be_successful
      end

      it 'returns a 200 response' do
        sign_in @user
        get :edit, params: { user_id: @user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'return a 302 response' do
        get :edit, params: { user_id: @user.id }
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :edit, params: { user_id: @user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#update' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'returns a 302 response' do
        sign_in @user
        patch :update, params: { user_id: @user.id,
                                 user: FactoryBot.attributes_for(:form_user) }
        expect(response).to have_http_status '302'
      end
    end

    context 'as a guest' do
      before do
        @user = FactoryBot.create(:user, :confirmed)
      end

      it 'redirects to the sign-in page' do
        patch :update, params: { user_id: @user.id,
                                 user: FactoryBot.attributes_for(:form_user) }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
