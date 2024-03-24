# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::ModelsByDate do
  describe '#call' do
    subject { described_class.call(model: model, date: date) }

    let(:model) { User }
    let(:date) { Time.zone.today }
    let(:users) { create_list(:user, 5) }
    let(:log_file_path) { "tmp/Users - #{date}.csv" }

    context 'when we have 5 users' do
      it 'create a file' do
        users
        subject

        expect(File.exist?(log_file_path)).to be(true)
      end
    end
  end
end
