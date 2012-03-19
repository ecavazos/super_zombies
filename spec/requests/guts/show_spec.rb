require 'spec_helper'

describe 'Viewing gut details', :js => true do

  it 'allows a user to view a gut' do
    gut = Gut.gen :kind => 'Infested', :species => 'Human'

    visit gut_path(gut)

    find('h1').should have_content('Gut Details')

    within '#details' do
      find('#kind'   ).should have_content('Kind: Infested')
      find('#species').should have_content('Species: Human')
    end
  end
end
