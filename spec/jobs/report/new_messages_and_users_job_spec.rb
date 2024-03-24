# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Report::NewMessagesAndUsersJob do
  describe '#perform' do
    subject { described_class.new.perform(model) }

    let(:model) { 'User' }

    context 'when parameters pass' do
      before do
        allow(Importer::ModelsByDate).to receive(:call)
      end

      it 'run Importer::ModelsByDate' do
        subject

        expect(Importer::ModelsByDate).to have_received(:call)
      end
    end
  end
end
