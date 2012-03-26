require 'spec_helper'
require 'yajl'

describe 'Zombies' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def should_be_zombie_json(json, zombie)
    json['id'].should                  == zombie.id
    json['name'].should                == zombie.name
    json['gender'].should              == zombie.gender
    json['age'].should                 == zombie.age
    json['created_at'].should          == zombie.created_at.as_json
    json['brain']['id'].should         == zombie.brain.id
    json['brain']['kind'].should       == zombie.brain.kind
    json['brain']['size'].should       == zombie.brain.size
    json['brain']['created_at'].should == zombie.brain.created_at.as_json
    json['gut']['id'].should           == zombie.gut.id
    json['gut']['kind'].should         == zombie.gut.kind
    json['gut']['species'].should      == zombie.gut.species
    json['gut']['created_at'].should   == zombie.gut.created_at.as_json

    json.should_not         have_key('updated_at')
    json.should_not         have_key('brain_id')
    json.should_not         have_key('gut_id')
    json[:brain].should_not have_key('updated_at') if json[:brain]
    json[:gut].should_not   have_key('updated_at') if json[:gut]
  end

  context 'Index' do

    it 'should return all zombies' do
      Zombie.gen :name => 'Vash'
      Zombie.gen :name => 'Wolfwood'
      Zombie.gen :name => 'Meryl'
      Zombie.gen :name => 'Milly'

      get '/api/v1/zombies.json'

      last_response.headers['Content-Type'].should == 'application/json'
      last_response.status.should == 200

      zombies = Zombie.all

      Yajl.load(last_response.body).each_with_index do |response, i|
        should_be_zombie_json response, zombies[i]
      end
    end

    it 'does not include brain or gut when nil' do
      Zombie.gen :name => 'Vash', :brain => nil, :gut => nil

      get '/api/v1/zombies.json'

      json = Yajl.load(last_response.body)

      json.first.should_not have_key(:brain)
      json.first.should_not have_key(:gut)
    end
  end

  context 'Create' do

    it 'should create a zombie and return the zombie as json' do
      Zombie.count.should == 0

      post '/api/v1/zombies.json', {
        :name     => 'UUURRGGH',
        :gender   => 'Male',
        :age      => 22,
        :brain_id => Brain.gen.id,
        :gut_id   => Gut.gen.id
      }

      Zombie.count.should == 1

      last_response.headers['Content-Type'].should == 'application/json'
      last_response.status.should == 200

      zombie = Zombie.first
      json   = Yajl.load(last_response.body)

      should_be_zombie_json json, zombie
    end

    it 'should create brain and gut when post data does not contain thier ids' do
      Zombie.count.should == 0
      Brain.count.should  == 0
      Gut.count.should    == 0

      post '/api/v1/zombies.json', {
        :name        => 'UUURRGGH',
        :gender      => 'Male',
        :age         => 22,
        :brain_kind  => 'Damaged',
        :brain_size  => 'Medium',
        :gut_kind    => 'Juicy',
        :gut_species => 'Bear'
      }

      Zombie.count.should == 1
      Brain.count.should  == 1
      Gut.count.should    == 1

      last_response.headers['Content-Type'].should == 'application/json'
      last_response.status.should == 200

      zombie = Zombie.first
      json   = Yajl.load(last_response.body)

      json.should_not have_key('updated_at')
      should_be_zombie_json json, zombie
    end

    it 'should respond with 400 when post data is not valid' do
      Zombie.count.should == 0

      post '/api/v1/zombies.json', :name => 'UUURRGGH'

      Zombie.count.should == 0

      last_response.headers['Content-Type'].should == 'application/json'
      last_response.status.should == 400
      last_response.body.should == ''
    end
  end
end

