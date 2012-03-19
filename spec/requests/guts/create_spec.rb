require 'spec_helper'

describe 'Creating guts', :js => true do

  it 'should allow users to create guts' do
    visit new_gut_path

    find('h1').should have_content('Gut Create')

    Gut.count.should == 0

    within '#new_gut' do
      fill_in 'Kind',    :with => 'Rotten'
      fill_in 'Species', :with => 'Elephant'

      click_button 'Bon Appétit'
    end

    find('#notice').should have_content('Mmmmmm Guts.')

    current_path.should == guts_path

    Gut.count.should == 1

    gut = Gut.first
    gut.kind.should    == 'Rotten'
    gut.species.should == 'Elephant'
  end

  it 'should inform user when gut is not valid' do
    visit new_gut_path

    Gut.count.should == 0

    within '#new_gut' do
      fill_in 'Kind',    :with => ''
      fill_in 'Species', :with => ''

      click_button 'Bon Appétit'
    end

    errors = all('.error')
    errors[0].text.should == "Kind can't be blank"
    errors[1].text.should == "Species can't be blank"
  end
end
