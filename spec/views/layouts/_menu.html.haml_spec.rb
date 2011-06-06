require 'spec_helper'

describe "layouts/_menu.html.haml" do
  let(:section1){mock_model Section, :name => "Section 1"}
  let(:section2){mock_model Section, :name => "Section 2"}
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    assign :sections, [section1, section2]
  end
  
  it "shows names of given sections" do
    render
    rendered.should contain("Section 1")
    rendered.should contain("Section 2")
  end
  
  it "shows links to given sections" do
    render
    rendered.should have_selector("a", :href => section_path(section1))
    rendered.should have_selector("a", :href => section_path(section2))
  end
  
  it "selects current section if given" do
    assign :section, section2
    render
    rendered.should have_selector("li.selected") do |selected|
      selected.should contain("Section 2")
    end
  end
  
  it "selects contacts menuitem when controller is contacts" do
    params[:controller] = "contacts"
    render
    rendered.should have_selector("li.selected a", :href => contacts_path)
  end
end
