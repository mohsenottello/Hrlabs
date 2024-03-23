# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user, email: email, json_web_token: json_web_token) }
  let(:json_web_token) { 'test' }
  let(:email) { 'test@gmail.com' }

  describe 'valid model' do
    it 'show it is valid' do
      expect(user).to be_valid
    end
  end

  describe 'invalid model' do
    describe 'not uniq email' do
      let(:user_2) { create(:user, email: email, json_web_token: json_web_token) }

      it 'show it is invalid' do
        user_2

        expect(user).not_to be_valid
      end
    end

    describe 'wrong email' do
      let(:email) { '@mmm@gmail.com' }

      it 'show it is invalid' do
        expect(user).not_to be_valid
      end
    end

    describe 'without email' do
      let(:email) { nil }

      it 'show it is invalid' do
        expect(user).not_to be_valid
      end
    end

    describe 'without json_web_token' do
      let(:json_web_token) { nil }

      it 'show it is invalid' do
        expect(user).not_to be_valid
      end
    end
  end
end
