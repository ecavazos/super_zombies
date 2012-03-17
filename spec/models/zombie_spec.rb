require 'spec_helper'

describe Zombie, 'mass assignment' do

  it 'does not raise when happy' do
    lambda {
      Zombie.create! :name => 'Mary', :gender => 'Female', :age => 22
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
    Zombie.gen(:age => 12.0).should_not be_valid
    Zombie.gen(:age => '12').should     be_valid
    Zombie.gen(:age =>   12).should     be_valid
  end
end
