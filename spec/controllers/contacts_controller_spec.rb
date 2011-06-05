require 'spec_helper'

describe ContactsController do
  describe "GET index" do
    let(:contacts_static_block){mock_model(StaticBlock, :text => "Greetings!")}
    let(:contact_message){mock_model(ContactMessage).as_new_record}
    before :each do
      StaticBlock.stub(:get_block).and_return contacts_static_block
      ContactMessage.stub(:new).and_return contact_message
    end
    
    it "asks 'contacts' static block" do
      StaticBlock.should_receive(:get_block).with 'contacts'
      get :index, :locale => 'en'
    end
    
    it "assigns text of 'contacts' static block" do
      get :index, :locale => 'en'
      assigns[:contact_info].should == "Greetings!"
    end
    
    it "assigns new contact message to @contact" do
      get :index, :locale => 'en'
      assigns[:contact].should == contact_message
    end
    
    it "creates new contact message from flash[:contact]" do
      ContactMessage.should_receive(:new).with "name"=>"Vasia"
      get :index, {:locale => 'en'}, nil, {:contact => {"name"=>"Vasia"}}
    end
    
    it "renders index template" do
      get :index, :locale => 'en'
      response.should render_template(:index)
    end
  end
  
  describe "POST create" do
    let(:contact_message){mock_model(ContactMessage, :save => true).as_new_record}
    before :each do
      ContactMessage.stub(:new).and_return contact_message
    end
    
    it "creates new contact message" do
      ContactMessage.should_receive(:new).with "name"=>"Vasia"
      post :create, :locale => 'en', :contact => {"name"=>"Vasia"}
    end
    
    it "saves the contact message" do
      contact_message.should_receive :save
      post :create, :locale => 'en'
    end
    
    it "redirects to index" do
      post :create, :locale => 'en'
      response.should redirect_to(contacts_path)
    end
    
    it "sets flash[:notice] when saving succesfull" do
      post :create, :locale => 'en'
      flash[:notice].should=~ /.+/
    end
    
    context "when saving failed" do
      before :each do
        contact_message.stub(:save).and_return false
      end
      
      it "sets flash[:alert]" do
        post :create, :locale => 'en'
        flash[:alert].should=~ /.+/
      end
      
      it "sets flash[:category] with params[:category]" do
        post :create, :locale => 'en', :contact => {"name"=>"Vasia"}
        flash[:contact].should == {"name"=>"Vasia"}
      end
    end
  end
end
