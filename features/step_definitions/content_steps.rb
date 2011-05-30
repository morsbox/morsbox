Given /^static block with name "([^"]*)" and text "([^"]*)"$/ do |name, text|
  Factory :static_block, :name => name, :text_ru => text
end