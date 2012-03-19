Factory.define :brain do |f|
  f.kind 'Insane'
  f.size 'Huge'
end

Factory.define :gut do |f|
  f.kind    'Crunchy'
  f.species 'Rabbit'
end

Factory.define :zombie do |f|
  f.name   'Meehhrrrr'
  f.gender 'Female'
  f.age    '44'
  f.brain  { Brain.gen }
  f.gut    { Gut.gen }
end

