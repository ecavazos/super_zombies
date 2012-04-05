require 'spec_helper'

describe 'Creating brains', :js => true do

  it 'should allow users to create brains' do
    visit new_brain_path

    find('h1').should have_content('Brain Create')

    Brain.count.should == 0

    within '#new_brain' do
      fill_in 'Kind', :with => 'Playful'
      fill_in 'Size', :with => 'Medium'

      click_button 'Nom Nom'
    end

    find('#notice').should have_content('Mmmmmm Brains.')

    current_path.should == brains_path

    Brain.count.should == 1

    brain = Brain.first
    brain.kind.should == 'Playful'
    brain.size.should == 'Medium'
  end

  it 'should inform user when brain is not valid' do
    visit new_brain_path

    Brain.count.should == 0

    within '#new_brain' do
      fill_in 'Kind', :with => ''
      fill_in 'Size', :with => ''

      click_button 'Nom Nom'
    end

    errors = all('.error')
    errors[0].text.should == "Kind can't be blank"
    errors[1].text.should == "Size can't be blank"
  end
end
