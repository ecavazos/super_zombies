require 'spec_helper'

describe 'Creating zombies', :js => true do

  it 'should allow users to create zombies' do
    visit new_zombie_path

    find('h1').should have_content('Zombie Create')

    Zombie.count.should == 0

    within '#new_zombie' do
      fill_in 'Name',   :with => 'Francesco'
      fill_in 'Gender', :with => 'Male'
      fill_in 'Age',    :with => '32'

      click_button 'Unleash Carnage'
    end

    find('#notice').should have_content('Your new zombie has been added to the horde.')

    current_path.should == zombies_path

    Zombie.count.should == 1

    zombie = Zombie.first
    zombie.name.should   == 'Francesco'
    zombie.gender.should == 'Male'
    zombie.age.should    == 32
  end

  it 'should inform user when zombie configuration is not valid' do
    visit new_zombie_path

    Zombie.count.should == 0

    within '#new_zombie' do
      fill_in 'Name',   :with => ''
      fill_in 'Gender', :with => ''
      fill_in 'Age',    :with => 'not_an_int'

      click_button 'Unleash Carnage'
    end

    errors = all('.error')
    errors[0].text.should == "Name can't be blank"
    errors[1].text.should == "Gender can't be blank"
    errors[2].text.should == "Age is not a number"
  end
end
