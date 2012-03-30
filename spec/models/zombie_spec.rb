require 'spec_helper'

describe Zombie, 'mass assignment' do

  it 'does not raise when happy' do
    lambda {
      Zombie.create!({
        :name     => 'Mary',
        :gender   => 'Female',
        :age      => 22,
        :brain_id => Brain.gen.id,
        :gut_id   => Gut.gen.id
      })
    }.should_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it 'raises when not happy' do
    lambda {
      Zombie.create! :foos => 'bar'
    }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end
end

describe Zombie, 'validation' do

  it 'requires a name' do
    Zombie.gen(:name => nil).should_not be_valid
    Zombie.gen(:name => 'z').should     be_valid
  end

  it 'requires a gender' do
    Zombie.gen(:gender =>    nil).should_not be_valid
    Zombie.gen(:gender => 'Male').should     be_valid
  end

  it 'requires an age' do
    Zombie.gen(:age => nil).should_not be_valid
    Zombie.gen(:age =>  12).should     be_valid
  end

  it 'requires age to be an int' do
    Zombie.gen(:age => 'ze').should_not be_valid
    Zombie.gen(:age => 1.0 ).should_not be_valid
    Zombie.gen(:age => '12').should     be_valid
    Zombie.gen(:age =>  12 ).should     be_valid
  end
end

describe Zombie, '#brain=' do

  it 'can have a favorite kind of brain' do
    brain = Brain.gen
    zombie = Zombie.gen :brain => brain

    zombie.brain.should == brain
  end
end

describe Zombie, '#gut=' do

  it 'can have a favorite kind of gut' do
    gut = Gut.gen
    zombie = Zombie.gen :gut => gut

    zombie.gut.should == gut
  end
end

describe Zombie, '.build_from_hash' do

  it 'can make a new zombie from hash' do
    brain = Brain.gen
    gut   = Gut.gen

    zombie = Zombie.build_from_hash \
      :name     => 'UUURRGGH',
      :gender   => 'Male',
      :age      => 22,
      :brain_id => brain,
      :gut_id   => gut

    zombie.name.should   == 'UUURRGGH'
    zombie.gender.should == 'Male'
    zombie.age.should    == 22
    zombie.brain.should  == brain
    zombie.gut.should    == gut
  end

  it 'can make a new zombie along with the brain and gut when the ids are not provided' do
    zombie = Zombie.build_from_hash \
      :name        => 'UUURRGGH',
      :gender      => 'Male',
      :age         => 22,
      :brain_kind  => 'Damaged',
      :brain_size  => 'Medium',
      :gut_kind    => 'Juicy',
      :gut_species => 'Bear'

    zombie.name.should   == 'UUURRGGH'
    zombie.gender.should == 'Male'
    zombie.age.should    == 22

    zombie.brain.kind.should  == 'Damaged'
    zombie.brain.size.should  == 'Medium'

    zombie.gut.kind.should    == 'Juicy'
    zombie.gut.species.should == 'Bear'
  end
end
