require 'spec_helper'
require 'yajl'

describe 'Zombies' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  it 'should return all zombies' do
    zombies = []
    zombies << Zombie.gen(:name => 'Vash')
    zombies << Zombie.gen(:name => 'Wolfwood')
    zombies << Zombie.gen(:name => 'Meryl')
    zombies << Zombie.gen(:name => 'Milly')

    get '/api/v1/zombies.json'

    last_response.headers['Content-Type'].should == 'application/json'
    last_response.status.should == 200

    Yajl.load(last_response.body).each_with_index do |resp, i|
      zombie = zombies[i]

      resp['id'    ].should == zombie.id
      resp['name'  ].should == zombie.name
      resp['gender'].should == zombie.gender
      resp['age'   ].should == zombie.age

      resp['brain']['id'  ].should == zombie.brain.id
      resp['brain']['kind'].should == zombie.brain.kind
      resp['brain']['size'].should == zombie.brain.size

      resp['gut']['id'     ].should == zombie.gut.id
      resp['gut']['kind'   ].should == zombie.gut.kind
      resp['gut']['species'].should == zombie.gut.species
    end
  end
end

