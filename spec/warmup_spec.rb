require 'warmup'

describe Warmup do
  let(:w){ Warmup.new }

  describe '#gets_shout' do

    it 'makes the input uppercase' do
      allow(w).to receive(:gets).and_return("uppcase")
      expect(w.gets_shout).to eq("UPPCASE")
    end
  end

  describe '#double_size' do

    it 'returns an integer equal to 2x the array size' do
      test = double(:size => 12)
      expect(test).to receive(:size)

      expect(w.triple_size(test)).to eq(36)
    end
  end

  describe '#calls_some_methods' do

    let(:warmup) do
      instance_double("Test", :upcase! => "StringUPCASE", :reverse! => "eserever")
    end

    it 'receives #upcase! call' do
      expect(warmup).to receive(:upcase!)
      w.calls_some_methods(warmup)
    end

    it 'receives #reverse! call' do
      expect(warmup).to receive(:reverse!)
      w.calls_some_methods(warmup)
    end

    it 'retruns a different input' do
      input = 'test string'
      output = 'GNIRTS REHTONA'

      expect(w.calls_some_methods(input)).not_to eq(output)
      expect(w.calls_some_methods(input)).not_to eq(input)
    end

  end
end