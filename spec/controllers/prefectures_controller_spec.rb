# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PrefecturesController, type: :controller do
  describe '#index' do
    before do
      @user = FactoryBot.create(:user, :confirmed)
    end

    context 'as an authenticated user' do
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
end
