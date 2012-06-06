require 'spec_helper'

describe "feedbacks/show.html.erb" do
  before(:each) do
    @feedback = assign(:feedback, stub_model(Feedback,
      :user_id => 1,
      :content => "Content",
      :email => "Email",
      :phone_number => "Phone Number",
      :lat_lon => "Lat Lon",
      :source => "Source",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Content/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lat Lon/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Source/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
  end
end
