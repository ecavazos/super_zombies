require 'spec_helper'

describe 'Listing brains', :js => true do

  it 'list all the brains' do
    Brain.gen :kind => 'Smart',    :size => 'Large'
    Brain.gen :kind => 'Clever',   :size => 'Small'
    Brain.gen :kind => 'Dumb',     :size => 'Medium'
    Brain.gen :kind => 'Genius',   :size => 'X-Large'
    Brain.gen :kind => 'Creative', :size => 'Small'

    visit brains_path

    find('h1').should have_content('Brains')

    all('thead th').map(&:text).should == ['Kind', 'Size', '', '']

    all('tbody tr').count.should == 5

    Brain.all.each do |brain|
      row = find("#brain_#{ brain.id }")
      row.all('td').map(&:text).should == [brain.kind, brain.size, 'Edit', 'Delete']
    end
  end

  it 'links the kind of brain to show page' do
    brain = Brain.gen :kind => 'Estupido', :size => 'Tiny'

    visit brains_path

    click_link 'Estupido'

    current_path.should == brain_path(brain)
  end

  it 'links to the create brain page' do
    visit brains_path

    click_link 'New Brain'

    current_path.should == new_brain_path
  end

  it 'links to the edit brain page' do
    brain = Brain.gen

    visit brains_path

    click_link 'Edit'

    current_path.should == edit_brain_path(brain)
  end

  it 'allows brains to be deleted' do
    Brain.gen

    visit brains_path

    click_link 'Delete'

    Brain.count.should == 0

    all('tbody tr').count.should == 0

    find('#notice').should have_content('One less brain to worry about.')
  end

end
