require 'spec_helper'

describe 'Editing brains', :js => true do

  it 'should allow users to edit brains' do
    brain = Brain.gen :kind => 'Challenged'

    visit edit_brain_path(brain)

    find('h1').should have_content('Brain Edit')

    within "#edit_brain_#{ brain.id }" do
      fill_in 'Kind', :with => 'Impaired'
      click_button 'Bon Appétit'
    end

    find('#notice').should have_content('Exquisite brain.')

    current_path.should == brains_path

    brain.reload.kind.should == 'Impaired'
  end

  it 'should inform user when brain is not valid' do
    brain = Brain.gen

    visit edit_brain_path(brain)

    within "#edit_brain_#{ brain.id }" do
      fill_in 'Kind', :with => ''
      fill_in 'Size', :with => ''

      click_button 'Bon Appétit'
    end

    errors = all('.error')
    errors[0].text.should == "Kind can't be blank"
    errors[1].text.should == "Size can't be blank"
  end
end
