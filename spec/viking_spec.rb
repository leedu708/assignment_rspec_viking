require 'viking'

describe Viking do
  let(:v){ Viking.new("Chad", 50, 5) }
  let(:axe){ Axe.new }
  let(:bow){ Bow.new }
  let(:v2){ Viking.new("Brad", 50, 5) }
  let(:viking_double) { double(:name => nil, :receive_attack => nil) }

  describe '#initialize' do
    
    it 'sets name attribute when passed a name' do
      expect(v.name).to eq("Chad")
    end

    it 'sets health attribute when passed a health value' do
      expect(v.health).to eq(50)
    end

    it 'should set weapon to nil by default' do
      expect(v.weapon).to eq(nil)
    end

    it 'should not be able to overwrite health after being set' do
      expect{v.health = 100}.to raise_error
    end

  end

  describe '#pick_up_weapon' do

    it 'should set @weapon to weapon that is picked up' do
      v.pick_up_weapon(axe)
      expect(v.weapon).to eq(axe)
    end

    it 'should raise exception when picking up a non-weapon' do
      expect{v.pick_up_weapon(12)}.to raise_error("Can't pick up that thing")
    end

    it 'should replace existing weapon with new weapon' do
      v.pick_up_weapon(axe)
      expect(v.weapon.name).to eq("Axe")
      v.pick_up_weapon(bow)
      expect(v.weapon).to be_a(Bow)
    end

    describe '#drop_weapon' do
      specify 'weapon should be nil' do
        v.pick_up_weapon(axe)
        v.drop_weapon
        expect(v.weapon).to eq(nil)
      end
    end

  end

  describe '#receive_attack' do

    it 'reduces vikings health by specified amount' do
      v.receive_attack(10)
      expect(v.health).to eq(40)
    end

    it 'reduces health of attacked viking' do
      current_health = v.health
      v.receive_attack(10)
      expect(v.health).to be < current_health
    end

    it 'causes attacked viking to call #take_damage' do
      expect(v).to receive(:take_damage)
      v.receive_attack(10)
    end

  end

  describe '#attack' do

    it 'runs #damage_with_fists when attacking without a weapon' do
      allow(v).to receive(:puts)
      expect(v).to receive(:damage_with_fists).and_return(:damage_dealt)
      v.attack(viking_double)
    end

    it 'attacks with the proper input weapon' do
      allow(v).to receive(:puts)
      damage_amount = v.strength * Fists.new.use
      expect(viking_double).to receive(:receive_attack).with(damage_amount)
      v.attack(viking_double)
    end

    it "deals damage equal to Viking's strength * weapon" do
      v.pick_up_weapon(axe)
      init_health = v2.health
      v.attack(v2)
      health_after = v2.health
      damage = v.weapon.use * v.strength
      expect(init_health - health_after).to eq(damage)
    end

    it 'will #attack target with fists if bow has no arrows' do
      bow = Bow.new(0)
      v.pick_up_weapon(bow)
      expect(v).to receive(:damage_with_fists)
      v.attack(viking_double)
    end

    it 'will raise an error if #receive_attack kills a viking' do
      expect{v.receive_attack(50)}.to raise_error
    end

  end

end