# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::ArrayToCsv do
  describe '#call' do
    subject { described_class.call(array: array, file_name: 'test') }

    let(:array) { [{ a: :a }] }
    let(:log_file_path) { 'tmp/test.csv' }

    context 'with existing array' do
      it 'run create file' do
        subject

        expect(File.exist?(log_file_path)).to be(true)
      end
    end
  end
end
