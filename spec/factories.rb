Factory.define :static_block do |f|
  f.name "Some block"
end

Factory.define :section do |f|
  f.name_ru "Some Section"
end

Factory.define :project do |f|
  f.name_ru "Some Project"
end

Factory.define :description do |f|
end

Factory.define :admin do |f|
  f.email "admin@domain.com"
  f.password "123456"
  f.password_confirmation { |x| x.password }
  f.remember_me true
end

Factory.define :contact_message do |f|
  f.name "Vasia"
  f.email "vasia@domian.com"
  f.phone "1233112"
  f.message "Your works are great!"
end
