require 'spec_helper'

describe 'Welcome (aka Homepage)', :js => true do

  it 'should be ze homepage' do
    visit root_path
    find('h1').should have_content('Welcome to the Super Zombies website')
  end
end
