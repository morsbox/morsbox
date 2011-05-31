Factory.define :static_block do |sb|

end

Factory.define :section do |s|

end

Factory.define :admin do |a|
  a.email "admin@domain.com"
  a.password "123456"
  a.password_confirmation { |x| x.password }
  a.remember_me true
end