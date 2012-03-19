Factory.define :zombie do |f|
  f.name   'Meehhrrrr'
  f.gender 'Female'
  f.age    '44'
end

Factory.define :brain do |f|
  f.kind 'Insane'
  f.size 'Huge'
end

Factory.define :gut do |f|
  f.kind    'Crunchy'
  f.species 'Rabbit'
end
