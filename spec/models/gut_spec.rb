require 'spec_helper'

describe Gut, 'validations' do

  it 'requires a kind' do
    Gut.gen(:kind =>     nil).should_not be_valid
    Gut.gen(:kind => 'Juicy').should     be_valid
  end

  it 'requires a species' do
    Gut.gen(:species =>     nil).should_not be_valid
    Gut.gen(:species => 'Human').should     be_valid
  end
end
