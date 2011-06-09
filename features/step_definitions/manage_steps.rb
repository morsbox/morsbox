When /^I submit edit form for section "([^"]*)"$/ do |name|
  When %{I submit "edit_section_#{Section.find_by_name_ru(name).id}"}
end