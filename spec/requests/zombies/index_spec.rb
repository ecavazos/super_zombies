require 'spec_helper'

describe 'Listing zombies', :js => true do

  it 'list all the zombies' do
    Zombie.gen :name => 'ap', :gender => 'Male', :age => 50
    Zombie.gen :name => 'oc', :gender => 'Male', :age => 50
    Zombie.gen :name => 'al', :gender => 'Male', :age => 50
    Zombie.gen :name => 'yp', :gender => 'Male', :age => 50
    Zombie.gen :name => 'se', :gender => 'Male', :age => 50

    visit zombies_path

    find('h1').should have_content('Zombies')

    all('thead th').map(&:text).should == ['Name', 'Gender', 'Age', '', '']

    all('tbody tr').count.should == 5

    Zombie.all.each do |zombie|
      row = find("#zombie_#{ zombie.id }")
      row.all('td').map(&:text).should == [zombie.name, zombie.gender, zombie.age.to_s, 'Edit', 'Delete']
    end
  end

  it 'links the name of a zombie to show page' do
    zombie = Zombie.gen :name => 'HungerPangs', :gender => 'Male', :age => 50

    visit zombies_path

    click_link 'HungerPangs'

    current_path.should == zombie_path(zombie)
  end

  it 'links to the create zombie page' do
    visit zombies_path

    click_link 'New Zombie'

    current_path.should == new_zombie_path
  end

  it 'links to the edit zombie page' do
    zombie = Zombie.gen :name => 'HungerPangs', :gender => 'Male', :age => 50

    visit zombies_path

    click_link 'Edit'

    current_path.should == edit_zombie_path(zombie)
  end

  it 'allows zombies to be deleted' do
    Zombie.gen :name => 'HungerPangs', :gender => 'Male', :age => 50

    visit zombies_path

    click_link 'Delete'

    Zombie.count.should == 0

    all('tbody tr').count.should == 0

    find('#notice').should have_content('You have successfully deleted one of the undead.')
  end

end
