# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Report::NewMessagesAndUsersJob do
  describe '#perform' do
    subject { described_class.new.perform(model, date) }

    let(:model) { User }
    let(:date) { Date.yesterday }

    context 'when parameters pass' do
      before do
        allow(Importer::ModelsByDate).to receive(:call)
      end

      it 'run without error' do
        expect { subject }.not_to raise_error
      end
    end
  end
end
