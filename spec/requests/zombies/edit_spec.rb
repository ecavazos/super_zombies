require 'spec_helper'

describe 'Editing zombies', :js => true do

  before do
    @brain1 = Brain.gen :kind => 'Silly', :size => 'Small'
    @brain2 = Brain.gen :kind => 'Smart', :size => 'Large'

    @gut1 = Gut.gen :kind => 'Bloody', :species => 'Horse'
    @gut2 = Gut.gen :kind => 'Crispy', :species => 'Human'
  end

  it 'should allow users to edit zombies' do
    zombie = Zombie.gen :name => 'Francesco'

    visit edit_zombie_path(zombie)

    find('h1').should have_content('Zombie Edit')

    within "#edit_zombie_#{ zombie.id }" do
      fill_in 'Name', :with => 'Franny'

      select 'Smart',  :from => 'Fav Brains'
      select 'Bloody', :from => 'Fav Guts'

      click_button 'Unleash Carnage'
    end

    find('#notice').should have_content('Zombies heart accurate data.')

    current_path.should == zombies_path

    zombie.reload.name.should == 'Franny'
    zombie.brain.should       == @brain2
    zombie.gut.should         == @gut1
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
