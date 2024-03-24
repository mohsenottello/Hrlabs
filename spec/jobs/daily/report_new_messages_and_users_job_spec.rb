# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Daily::ReportNewMessagesAndUsersJob do
  describe '#perform' do
    subject { described_class.new.perform }

    context 'when parameters pass' do
      before do
        allow(Report::NewMessagesAndUsersJob).to receive(:perform_in)
      end

      it 'run Report::NewMessagesAndUsersJob' do
        subject

        expect(Report::NewMessagesAndUsersJob).to have_received(:perform_in).twice
      end
    end
  end
end
