require 'spec_helper'

describe ActiveResourceInspector do
  subject(:inspector){  described_class::Base.new }
  it 'has a version number' do
    expect(ActiveResourceInspector::VERSION).not_to be nil
  end

  describe '#files' do
    before do
      inspector.dirname = './spec/fixtures/'
    end
    it 'returns only ruby files within given dirname' do
      expected = Dir[File.join(inspector.dirname, '**/*.rb')].sort
      expect(inspector.files).to eq(expected)
    end
  end

  describe '#resources' do
    before do
      inspector.dirname = './spec/fixtures/'
    end
    it 'handles subfolders & ingores modules' do
      expect{ inspector.resources }.to_not raise_error
    end

    it 'returns ActiveResource based classes && skips non-ActiveResource, modeules, ActiveResource abstract classes based on missing site option' do
      expect(inspector.resources).to eq([AddressResource, Admin::ProxyResource, Inventory])
    end
  end
end
