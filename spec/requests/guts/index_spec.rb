require 'spec_helper'

describe 'Listing guts', :js => true do

  it 'list all the guts' do
    Gut.gen :kind => 'Juicy',   :species => 'Cow'
    Gut.gen :kind => 'Bloated', :species => 'Human'
    Gut.gen :kind => 'Crunchy', :species => 'Dog'
    Gut.gen :kind => 'Chewy',   :species => 'Cat'
    Gut.gen :kind => 'Savory',  :species => 'Pig'

    visit guts_path

    find('h1').should have_content('Guts')

    all('thead th').map(&:text).should == ['Kind', 'Species', '', '']

    all('tbody tr').count.should == 5

    Gut.all.each do |gut|
      row = find("#gut_#{ gut.id }")
      row.all('td').map(&:text).should == [gut.kind, gut.species, 'Edit', 'Delete']
    end
  end

  it 'links the kind of gut to show page' do
    gut = Gut.gen :kind => 'Juicy', :species => 'Cow'

    visit guts_path

    click_link 'Juicy'

    current_path.should == gut_path(gut)
  end

  it 'links to the create gut page' do
    visit guts_path

    click_link 'New Gut'

    current_path.should == new_gut_path
  end

  it 'links to the edit gut page' do
    gut = Gut.gen

    visit guts_path

    click_link 'Edit'

    current_path.should == edit_gut_path(gut)
  end

  it 'allows guts to be deleted' do
    Gut.gen

    visit guts_path

    click_link 'Delete'

    Gut.count.should == 0

    all('tbody tr').count.should == 0

    find('#notice').should have_content('No guts no glory.')
  end

end
