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
    let(:all){ Dir[File.join(inspector.dirname, '**/*.rb')] }
    let(:not_active_resource){ "./spec/fixtures/not_active_resource_class.rb" }
    let(:a_module){ "./spec/fixtures/concerns/some_module.rb" }
    let(:abstract_active_resource){ "./spec/fixtures/abstract_active_resource_class.rb" }

    before do
      expect(File.exists?(not_active_resource)).to be_truthy
      expect(File.exists?(a_module)).to be_truthy
      expect(File.exists?(abstract_active_resource)).to be_truthy

      inspector.dirname = './spec/fixtures/'
    end
    it 'handles subfolders & ingores modeuls' do
      expect{ inspector.resources }.to_not raise_error
    end

    it 'returns ActiveResource based classes && skips non-ActiveResource, modeules, ActiveResource abstract classes based on missing site option' do
      expect(inspector.resources).to eq(all - [abstract_active_resource, not_active_resource, a_module])
    end
  end
end
