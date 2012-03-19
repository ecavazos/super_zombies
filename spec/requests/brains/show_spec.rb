require 'spec_helper'

describe 'Viewing brain details', :js => true do

  it 'allows a user to view a brain' do
    brain = Brain.gen

    visit brain_path(brain)

    find('h1').should have_content('Brain Details')

    within '#details' do
      find('#kind').should have_content('Kind: Insane')
      find('#size').should have_content('Size: Huge')
    end
  end
end
