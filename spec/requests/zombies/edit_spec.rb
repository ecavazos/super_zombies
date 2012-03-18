require 'spec_helper'

describe 'Editing zombies', :js => true do

  it 'should allow users to edit zombies' do
    zombie = Zombie.gen :name => 'Francesco'

    visit edit_zombie_path(zombie)

    find('h1').should have_content('Zombie Edit')

    within "#edit_zombie_#{ zombie.id }" do
      fill_in 'Name', :with => 'Franny'
      click_button 'Unleash Carnage'
    end

    find('#notice').should have_content('Zombies heart accurate data.')

    current_path.should == zombies_path

    zombie.reload.name.should == 'Franny'
  end

  it 'should inform user when zombie configuration is not valid' do
    zombie = Zombie.gen

    visit edit_zombie_path(zombie)

    within "#edit_zombie_#{ zombie.id }" do
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
