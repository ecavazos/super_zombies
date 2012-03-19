require 'spec_helper'

describe 'Viewing zombie details', :js => true do

  it 'allows a user to view a zombie' do
    brain  = Brain.gen :kind => 'Genius', :size => 'Huge'
    gut    = Gut.gen :kind => 'Crunchy', :species => 'Donkey'
    zombie = Zombie.gen :brain => brain, :gut => gut

    visit zombie_path(zombie)

    find('h1').should have_content('Zombie Details')

    within '#details' do
      find('#name'  ).should have_content('Name: Meehhrrrr')
      find('#gender').should have_content('Gender: Female')
      find('#age'   ).should have_content('Age: 44')
      find('#brain' ).should have_content('Fav Brains: Huge genius brains')
      find('#gut'   ).should have_content('Fav Guts: Crunchy donkey guts')
    end
  end
end
