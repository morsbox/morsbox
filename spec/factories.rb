Factory.define :static_block do |sb|

end

Factory.define :section do |s|

end

Factory.define :admin do |a|
  a.password "bar"
  a.password_confirmation { |x| x.password }
  a.remember_me true
end