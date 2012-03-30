require 'spec_helper'
require 'yajl'

describe 'Horde' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  context 'Index' do

    it 'should allow the batch creation of zombies' do
      Zombie.count.should == 0
      Brain.count.should  == 0
      Gut.count.should    == 0

      horde = { :zombies => [] }

      4.times do |i|
        horde[:zombies] << {
          :name        => "Zombie #{ i + 1 }",
          :gender      => 'Female',
          :age         => 22,
          :brain_kind  => 'Damaged',
          :brain_size  => 'Medium',
          :gut_kind    => 'Juicy',
          :gut_species => 'Bear'
        }
      end

      post '/api/v1/horde.json', horde

      Zombie.count.should == 4
      Brain.count.should  == 4
      Gut.count.should    == 4

      last_response.headers['Content-Type'].should == 'application/json'
      last_response.status.should == 200

      json = Yajl.load(last_response.body)

      json.each do |zombie_json|
        zombie = Zombie.find zombie_json['id']
        should_be_zombie_json zombie_json, zombie
      end
    end

    it 'should respond with 400 when post data is not valid' do
      horde = {
        :zombies => [{
          :name => 'Le Zombie'
        }]
      }

      Zombie.count.should == 0

      post '/api/v1/horde.json', horde

      Zombie.count.should == 0

      last_response.headers['Content-Type'].should == 'application/json'
      last_response.status.should == 400
      last_response.body.should == ''
    end
  end
end
