require 'spec_helper'

describe Brain, 'validations' do

  it 'requires a kind' do
    Brain.gen(:kind =>      nil).should_not be_valid
    Brain.gen(:kind => 'Insane').should     be_valid
  end

  it 'requires a size' do
    Brain.gen(:size =>   nil).should_not be_valid
    Brain.gen(:size => 'Big').should     be_valid
  end
end
