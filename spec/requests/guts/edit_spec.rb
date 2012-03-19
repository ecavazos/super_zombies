require 'spec_helper'

describe 'Editing guts', :js => true do

  it 'should allow users to edit guts' do
    gut = Gut.gen :kind => 'Infested'

    visit edit_gut_path(gut)

    find('h1').should have_content('Gut Edit')

    within "#edit_gut_#{ gut.id }" do
      fill_in 'Kind', :with => 'Evacuated'
      click_button 'Bon Appétit'
    end

    find('#notice').should have_content('Guts are better with hot sauce.')

    current_path.should == guts_path

    gut.reload.kind.should == 'Evacuated'
  end

  it 'should inform user when gut is not valid' do
    gut = Gut.gen

    visit edit_gut_path(gut)

    within "#edit_gut_#{ gut.id }" do
      fill_in 'Kind',    :with => ''
      fill_in 'Species', :with => ''

      click_button 'Bon Appétit'
    end

    errors = all('.error')
    errors[0].text.should == "Kind can't be blank"
    errors[1].text.should == "Species can't be blank"
  end
end
