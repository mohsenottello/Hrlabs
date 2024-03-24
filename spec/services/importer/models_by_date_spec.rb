# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::ModelsByDate do
  describe '#call' do
    subject { described_class.call(model: model, date: date) }

    let(:model) { 'User' }
    let(:date) { Time.zone.today }
    let(:users) { create_list(:user, 5) }
    let(:log_file_path) { "tmp/Users - #{date}.csv" }

    context 'when we have 5 users' do
      before do
        allow(Importer::ArrayToCsv).to receive(:call)
      end

      it 'run Importer::ArrayToCsv' do
        users
        subject

        expect(Importer::ArrayToCsv).to have_received(:call)
      end
    end
  end
end
