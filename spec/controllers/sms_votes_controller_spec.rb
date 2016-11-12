require 'rails_helper'

describe SmsVotesController, type: :controller do
  describe 'POST create' do
    let!(:competition) { create :current_competition }

    context 'fails to set temp user' do
      it 'responds with 422' do
        create_vote = -> { post :create, From: 'notanumber' }
        expect(create_vote.call).to have_http_status(:unprocessable_entity)
      end

      it 'does not send message' do
        post :create, From: 'notanumber'
        expect(SMSMessenger.client.messages).to be_empty
      end

      it 'does not create transaction' do
        create_vote = -> { post :create, From: 'notanumber' }
        expect{ create_vote.call }.to_not change{ Transaction.count }
      end
    end

    context 'fails to set project' do
      it 'responds with 404' do
        create_vote = -> { post :create, From: '1112221122', Body: 'notasmscode' }
        expect(create_vote.call).to have_http_status(:not_found)
      end

      it 'notifies temp user via sms' do
        from = '1112221122'
        post :create, From: from, Body: 'notasmscode'

        sms = SMSMessenger.client.messages.last
        expect(sms.to).to eq(from)
      end

      it 'does not create transaction' do
        create_vote = -> { post :create, From: '1112221122', Body: 'notasmscode' }
        expect{ create_vote.call }.to_not change{ Transaction.count }
      end
    end

    context 'creates vote' do
      it 'responds with 201' do
        sms_code = 'GOOD_CODE'
        competition.projects << create(:project, sms_code: sms_code )

        create_vote = -> { post :create, From: '1112221111', Body: sms_code }

        expect(create_vote.call).to have_http_status(:created)
      end

      it 'notifies temp user via sms' do
        from = '1112221111'
        sms_code = 'GOOD_CODE'
        competition.projects << create(:project, sms_code: sms_code )

        post :create, From: from, Body: sms_code

        sms = SMSMessenger.client.messages.last
        expect(sms.to).to eq(from)
      end

      it 'creates transaction' do
        from = '1112221111'
        sms_code = 'GOOD_CODE'
        competition.projects << create(:project, sms_code: sms_code )

        create_vote = -> { post :create, From: from, Body: sms_code }

        expect{ create_vote.call }.to change{ Transaction.count }.from(0).to(1)
      end

      it 'creates transaction with correct number of points' do
        competition.competition_config.update dollar_to_point: 123

        from = '1112221111'
        sms_code = 'GOOD_CODE'
        competition.projects << create(:project, sms_code: sms_code )

        post :create, From: from, Body: sms_code

        expect(Transaction.last.points).to eq(123)
      end
    end

    context 'temp user at vote limit' do
      it 'responds with 422' do
        # configure max votes
        competition.competition_config.update sms_votes_allowed: 1

        # setup otherwise valid request
        user = create :temp_user, phone: '1112221111'
        project = create :project, sms_code: 'GOOD_CODE'
        competition.projects << project

        # create pre-existing "vote"
        create :transaction, points: 1, sender: user, recipient: project,
          competition: competition

        post :create, From: user.phone, Body: project.sms_code

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create transaction' do
        # configure max votes
        competition.competition_config.update sms_votes_allowed: 1

        # setup data for otherwise valid request
        user = create :temp_user, phone: '1112221111'
        project = create :project, sms_code: 'GOOD_CODE'
        competition.projects << project

        # create pre-existing "vote"
        create :transaction, points: 1, sender: user, recipient: project,
          competition: competition

        create_vote = -> { post :create, From: user.phone, Body: project.sms_code }

        expect{ create_vote.call }.to_not change{ Transaction.count }
      end

      it 'notifies user' do
        # configure max votes
        competition.competition_config.update sms_votes_allowed: 1

        # setup data for otherwise valid request
        user = create :temp_user, phone: '1112221111'
        project = create :project, sms_code: 'GOOD_CODE'
        competition.projects << project

        # create pre-existing "vote"
        create :transaction, points: 1, sender: user, recipient: project,
          competition: competition

        post :create, From: user.phone, Body: project.sms_code

        sms = SMSMessenger.client.messages.last
        expect(sms.to).to eq(user.phone)
      end
    end
  end
end
