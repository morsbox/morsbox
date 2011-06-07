module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /the sign up page/
      '/admins/sign_up'

    when /the sign in page/
      '/admins/sign_in'

    when /the page of section "([^"]*)"/
      section_path Section.find_by_name_ru($1)
      
    when /the page of project "([^"]*)"/
      project_path Project.find_by_name_ru($1)
    
    when /the edit admin static block "([^"]*)" page/
      edit_admin_static_block_path StaticBlock.get_block($1)
    
    when /the edit admin section "([^"]*)" page/
      edit_admin_section_path Section.find_by_name_ru($1)
    
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
