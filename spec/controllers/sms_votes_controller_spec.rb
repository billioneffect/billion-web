require 'rails_helper'

describe SmsVotesController, type: :controller do
  describe 'POST create' do
    before { create :current_competition }

    context 'fails to set temp user' do
      it 'responds with 422' do
        create_vote = -> { post :create, From: 'notanumber' }
        expect(create_vote.call).to have_http_status(:unprocessable_entity)
      end
    end

    context 'fails to set project' do
      it 'responds with 404' do
        create_vote = -> { post :create, From: '1112221122', Body: 'notasmscode' }
        expect(create_vote.call).to have_http_status(:not_found)
      end

      it 'notifies temp user via sms' do
      end
    end

    context 'creates vote' do
      it 'responds with 201' do
      end

      it 'notifies temp user via sms' do
      end
    end

    context 'fails to create vote' do
      it 'responds with 422' do
      end

      it 'notifies temp user via sms' do
      end
    end
  end
end
