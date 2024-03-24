# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'correct meta and users' do |user_count:, per_page:, page:|
  let(:users) { create_list(:user, 5) }

  context 'with users' do
    it 'response successful' do
      users
      subject

      expect(response).to be_successful
      expect(response.body).to be_present
      expect(response.parsed_body['meta']).to be_present
      expect(response.parsed_body.dig('meta', 'page')).to eq(page)
      expect(response.parsed_body.dig('meta', 'per_page')).to eq(per_page)
      expect(response.parsed_body['users']).to be_present
      expect(response.parsed_body['users'].count).to eq(user_count)
      expect(response.parsed_body['users']).to(be_all { |u| u.keys == %w[email json_web_token] })
    end
  end
end

RSpec.describe Api::UsersController do
  describe '#create' do
    let(:email) { 'test@gmail.com' }

    describe 'successful path' do
      subject { post '/api/users', params: params }

      let(:params) { { email: email } }

      it 'response successful' do
        subject

        expect(response).to be_successful
        expect(response.body).to be_present
        expect(response.parsed_body.dig('user', 'email')).to eq(email)
        expect(response.parsed_body.dig('user', 'json_web_token')).to be_present
      end

      it 'create a user' do
        expect { subject }.to change(User, :count).by(1)
      end
    end

    describe 'unsuccessful path' do
      subject { post '/api/users', params: params }

      let(:params) { { email: email } }

      context 'without params' do
        let(:params) { {} }

        it 'response unprocessable_entity' do
          subject

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to be_present
          expect(response.parsed_body['errors']).to eq('Can not procceed!')
          expect(response.parsed_body['message']).to eq('parameter email is required.')
        end
      end

      context 'with wrong email type' do
        let(:params) { { email: 1 } }

        it 'response unprocessable_entity' do
          subject

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to be_present
          expect(response.parsed_body['errors']).to eq('Can not procceed!')
          expect(response.parsed_body['message']).to eq(['Email is invalid'])
        end
      end

      context 'with wrong email' do
        let(:params) { { email: '@@2@.com' } }

        it 'response unprocessable_entity' do
          subject

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to be_present
          expect(response.parsed_body['errors']).to eq('Can not procceed!')
          expect(response.parsed_body['message']).to eq(['Email is invalid'])
        end
      end
    end
  end

  describe '#index' do
    describe 'successful path' do
      subject { get '/api/users', params: params }

      context 'when we do not have anything' do
        let(:params) { {} }

        it_behaves_like 'correct meta and users', user_count: 5, per_page: 3, page: 0
      end

      context 'when we have per_page' do
        let(:params) { { per_page: 3 } }

        it_behaves_like 'correct meta and users', user_count: 3, per_page: 3, page: 0
      end

      context 'when we have per_page and page' do
        let(:params) { { page: 1, per_page: 3 } }

        it_behaves_like 'correct meta and users', user_count: 2, per_page: 3, page: 1
      end
    end
  end
end
