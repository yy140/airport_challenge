require 'airport'

describe Airport do
  describe '#land' do
    it 'raises an error if airport it full' do
      allow(subject).to receive(:stormy?).and_return(1)
      subject.airport_capacity.times { subject.land(Plane.new) }
      plane = Plane.new
      expect {raise subject.land(plane)}.to raise_error('The airport is full')
    end

     it 'raises an error if landing during a storm' do
      plane2 = Plane.new
      allow(subject).to receive(:stormy?).and_return(3)
      expect { subject.land(plane2)}.to raise_error('Too stormy to land')
     end
      
    it 'instructs a plane to land' do
      plane = Plane.new
      allow(subject).to receive(:stormy?).and_return(1)
      expect(subject.land(plane)).to eq [plane]
    end
  end

  describe '#take_off' do
    it 'raises error if taking off during a storm' do
      plane = Plane.new
      allow(subject).to receive(:stormy?).and_return(1) 
      subject.land(plane)
      allow(subject).to receive(:stormy?).and_return(3) 
      expect { subject.take_off(plane)}.to raise_error('Cannot take off due to storm')
    end

    it 'instructs a plane to take off' do
      plane = Plane.new
      allow(subject).to receive(:stormy?).and_return(1) 
      subject.land(plane)
      expect(subject.take_off(plane)).to eq plane
    end

    it 'confirms that plane is no longer at airport'do
    plane = Plane.new
    subject.take_off(plane)
    expect(subject.plane).not_to include(plane)
    end
  end

  describe '#stormy?' do
    it 'decides if weather is stormy or sunny' do
      expect(subject).to respond_to(:stormy?)
    end
    
    it 'will generate a random number when called' do
      allow(subject).to receive(:rand).and_return(3) 
      expect(subject.stormy?).to eq 3
    end
    
  end

end