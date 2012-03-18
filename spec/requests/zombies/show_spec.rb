require 'spec_helper'

describe 'Viewing zombie details', :js => true do

  it 'allows a user to view a zombie' do
    zombie = Zombie.gen

    visit zombie_path(zombie)

    find('h1').should have_content('Zombie Details')

    within '#details' do
      find('#name'  ).should have_content('Name: Meehhrrrr')
      find('#gender').should have_content('Gender: Female')
      find('#age'   ).should have_content('Age: 44')
    end
  end
end
