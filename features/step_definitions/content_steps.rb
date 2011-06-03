Given /^static block with name "([^"]*)" and text "([^"]*)"$/ do |name, text|
  Factory :static_block, :name => name, :text_ru => text
end

Given /^section with name "([^"]*)"$/ do |name|
  Factory :section, :name_ru => name
end

Given /^static block with name "([^"]*)" has english text "([^"]*)"$/ do |name, text|
  StaticBlock.get_block(name).update_attributes :text_en => text
end

Given /^section with name "([^"]*)" has english name "([^"]*)"$/ do |name_ru, name_en|
  Section.find_by_name_ru(name_ru).update_attributes :name_en => name_en
end

Given /^section "([^"]*)" has project with name "([^"]*)"$/ do |section_name, name|
  Section.find_by_name_ru(section_name).projects << Factory(:project, :name_ru => name)
end

Given /^project "([^"]*)" has following descriptions:$/ do |project_name, descriptions|
  project = Project.find_by_name_ru(project_name)
  descriptions.hashes.each do |description|
    project.descriptions << Factory(:description, description)
  end
end