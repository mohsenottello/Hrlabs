# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create, type: :feature do
  subject { described_class.new(email) }

  let(:email) { 'test@gmail.com' }

  describe 'invalid arg' do
    let(:email) { 1 }

    it 'raise ArgumentError' do
      expect { subject.call }.to raise_error(ArgumentError)
    end
  end

  describe 'valid arg' do
    it 'return user' do
      expect(subject.call).to be_a(User)
    end

    it 'increase number of user' do
      expect { subject.call }.to change(User, :count).by(1)
    end
  end
end
