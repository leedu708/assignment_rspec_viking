require 'weapons/bow'

describe Bow do
  let(:a){ Bow.new }

  describe '#initialize' do


    it 'initializes a bow with 10 arrows' do
      expect(a.arrows).to eq(10)
    end

    it 'gives valid value for arrow count' do
      expect(a.arrows).to be_a(Integer)
    end

    it 'can create a bow with a specified number of arrows' do
      test = Bow.new(5)
      expect(test.arrows).to eq(5)
    end

  end

  describe '#use' do

    it 'reduces @arrows by 1 when a bow is used' do
      a.use
      expect(a.arrows).to eq(9)
    end

    it 'throws an error when using a bow with 0 arrows' do
      test = Bow.new(0)
      expect{test.use}.to raise_error("Out of arrows")
    end

  end
end