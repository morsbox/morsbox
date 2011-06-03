require 'spec_helper'

describe "projects/show.html.haml" do
  let(:project1){mock_model(Project).as_null_object}
  let(:image){mock :image, :url => "/some/url/to/image.jpg"}
  let(:desc1){mock_model Description,:text=>"<p>Description 1</p>", :image => image}
  let(:desc2){mock_model Description,:text=>"<p class='text'>Description 2</p>",:image=>nil}
  before :each do
    assign :project, project1
    assign :projects, [project1]
    project1.stub_chain(:descriptions,:enabled).and_return [desc1, desc2]
    render
  end
  
  it "shows images of descriptions, when present" do
    rendered.should have_selector("img", :src => "/some/url/to/image.jpg")
  end
  
  it "shows text of descriptions, when present" do
    rendered.should contain("Description 1")
    rendered.should contain("Description 2")
  end
  
  it "shows tags in text of descriptions" do
    rendered.should have_selector("p", :class => "text")
  end
end