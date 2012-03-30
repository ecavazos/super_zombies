module JsonHelper

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

end
