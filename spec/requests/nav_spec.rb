require 'spec_helper'

describe 'Navigation', :js => true do

  it 'should link to home page' do
    visit zombies_path
    within '.navbar' do
      click_link 'SuperZombies'
    end
    current_path.should == root_path
  end

  it 'should link to zombies list page' do
    visit root_path
    within '.navbar' do
      click_link 'Zombies'
    end
    current_path.should == zombies_path
  end

  it 'should link to brains list page' do
    visit root_path
    within '.navbar' do
      click_link 'Brains'
    end
    current_path.should == brains_path
  end

  it 'should link to guts list page' do
    visit root_path
    within '.navbar' do
      click_link 'Guts'
    end
    current_path.should == guts_path
  end
end
