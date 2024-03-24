# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'correct meta and messages' do |message_count:, per_page:, page:|
  context 'with messages' do
    it 'response successful' do
      messages
      subject

      expect(response).to be_successful
      expect(response.body).to be_present
      expect(response.parsed_body['meta']).to be_present
      expect(response.parsed_body.dig('meta', 'page')).to eq(page)
      expect(response.parsed_body.dig('meta', 'per_page')).to eq(per_page)
      expect(response.parsed_body['messages']).to be_present
      expect(response.parsed_body['messages'].count).to eq(message_count)
      expect(response.parsed_body['messages']).to(be_all { |u| u.keys == %w[id title body] })
    end
  end
end

RSpec.shared_examples 'unathorized request' do
  let(:headers) { { Authorization: 'test' } }

  context 'with wrong Authorization' do
    it 'response unauthorized' do
      subject

      expect(response).to be_unauthorized
      expect(response.parsed_body).to be_present
      expect(response.parsed_body['errors']).to eq('Can not procceed!')
      expect(response.parsed_body['message']).to eq('invalid token')
    end
  end
end

RSpec.describe Api::MessagesController do
  describe '#create' do
    let(:user) { Users::Create.call('test@test.test') }
    let(:body) { 'test body' }
    let(:title) { 'test title' }
    let(:headers) { { Authorization: user.json_web_token } }

    describe 'successful path' do
      subject { post '/api/messages', params: params, headers: headers }

      let(:params) { { body: body, title: title } }

      it 'response successful' do
        subject

        expect(response).to be_successful
        expect(response.body).to be_present
        expect(response.parsed_body.dig('message', 'id')).to be_present
        expect(response.parsed_body.dig('message', 'title')).to eq(title)
        expect(response.parsed_body.dig('message', 'body')).to eq(body)
      end

      it 'create a message' do
        expect { subject }.to change(Message, :count).by(1)
      end
    end

    describe 'unsuccessful path' do
      subject { post '/api/messages', params: params, headers: headers }

      let(:params) { { body: body, title: title } }

      context 'without params' do
        let(:params) { {} }

        it 'response unprocessable_entity' do
          subject

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to be_present
          expect(response.parsed_body['errors']).to eq('Can not procceed!')
          expect(response.parsed_body['message']).to eq('parameter title is required.')
        end
      end

      it_behaves_like 'unathorized request'
    end
  end

  describe '#index' do
    describe 'successful path' do
      subject { get '/api/messages', params: params, headers: headers }

      let(:user) { Users::Create.call('test@test.test') }
      let(:messages) { create_list(:message, 5, user: user) }
      let(:headers) { { Authorization: user.json_web_token } }

      context 'when we do not have anything' do
        let(:params) { {} }

        it_behaves_like 'correct meta and messages', message_count: 5, per_page: 10, page: 0
      end

      context 'when we have per_page' do
        let(:params) { { per_page: 3 } }

        it_behaves_like 'correct meta and messages', message_count: 3, per_page: 3, page: 0
      end

      context 'when we have per_page and page' do
        let(:params) { { page: 1, per_page: 3 } }

        it_behaves_like 'correct meta and messages', message_count: 2, per_page: 3, page: 1
      end

      context 'when we have keyword' do
        let(:params) { { keyword: 'test' } }

        it_behaves_like 'correct meta and messages', message_count: 5, per_page: 10, page: 0
      end
    end

    describe 'unsuccessful path' do
      subject { get '/api/messages', headers: headers }

      it_behaves_like 'unathorized request'
    end
  end

  describe '#show' do
    describe 'successful path' do
      subject { get "/api/messages/#{message.id}", headers: headers }

      let(:user) { Users::Create.call('test@test.test') }
      let(:message) { create(:message, user: user) }
      let(:headers) { { Authorization: user.json_web_token } }

      context 'when we do not have anything' do
        it 'respond successful' do
          subject

          expect(response).to be_successful
          expect(response.body).to be_present
          expect(response.parsed_body.dig('message', 'id')).to be_present
          expect(response.parsed_body.dig('message', 'title')).to eq(message.title)
          expect(response.parsed_body.dig('message', 'body')).to eq(message.body)
        end
      end
    end

    describe 'unsuccessful path' do
      context 'when we do not have message' do
        subject { get '/api/messages/1', headers: headers }

        let(:user) { Users::Create.call('test@test.test') }
        let(:headers) { { Authorization: user.json_web_token } }

        it 'respond not_found' do
          subject

          expect(response).to have_http_status(:not_found)
          expect(response.body).to be_present
          expect(response.parsed_body['errors']).to eq('Can not procceed!')
          expect(response.parsed_body['message']).to eq('message cannot find')
        end
      end

      context 'when we have message' do
        subject { get "/api/messages/#{message.id}", headers: headers }

        let(:message) { create(:message) }

        it_behaves_like 'unathorized request'
      end
    end
  end

  describe '#update' do
    describe 'successful path' do
      subject { patch "/api/messages/#{message.id}", params: params, headers: headers }

      let(:user) { Users::Create.call('test@test.test') }
      let(:message) { create(:message, user: user) }
      let(:headers) { { Authorization: user.json_web_token } }

      context 'when we want to update title and body' do
        let(:params) { { title: new_title, body: new_body } }
        let(:new_title) { 'new title' }
        let(:new_body) { 'new body' }

        it 'respond successful' do
          subject

          expect(response).to be_successful
          expect(response.body).to be_present
          expect(response.parsed_body.dig('message', 'id')).to be_present
          expect(response.parsed_body.dig('message', 'title')).to eq(new_title)
          expect(response.parsed_body.dig('message', 'body')).to eq(new_body)
        end
      end
    end

    describe 'unsuccessful path' do
      context 'when we do not have message' do
        subject { get '/api/messages/1', headers: headers }

        let(:user) { Users::Create.call('test@test.test') }
        let(:headers) { { Authorization: user.json_web_token } }

        it 'respond not_found' do
          subject

          expect(response).to have_http_status(:not_found)
          expect(response.body).to be_present
          expect(response.parsed_body['errors']).to eq('Can not procceed!')
          expect(response.parsed_body['message']).to eq('message cannot find')
        end
      end

      context 'when we have message' do
        subject { get "/api/messages/#{message.id}", headers: headers }

        let(:message) { create(:message) }

        it_behaves_like 'unathorized request'
      end
    end
  end
end
