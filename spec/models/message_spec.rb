# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  let(:message) { build(:message, title: title, body: body, user: user) }
  let(:title) { 'test title' }
  let(:body) { 'test body' }
  let(:user) { create(:user) }

  describe 'valid model' do
    it 'show it is valid' do
      expect(message).to be_valid
    end
  end

  describe 'invalid model' do
    context 'without title' do
      let(:title) { nil }

      it 'show it is invalid' do
        expect(message).not_to be_valid
      end
    end

    context 'without email' do
      let(:user) { nil }

      it 'show it is invalid' do
        expect(message).not_to be_valid
      end
    end
  end
end
