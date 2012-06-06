require 'spec_helper'

describe "feedbacks/index.html.erb" do
  before(:each) do
    assign(:feedbacks, [
      stub_model(Feedback,
        :user_id => 1,
        :content => "Content",
        :email => "Email",
        :phone_number => "Phone Number",
        :lat_lon => "Lat Lon",
        :source => "Source",
        :status => "Status"
      ),
      stub_model(Feedback,
        :user_id => 1,
        :content => "Content",
        :email => "Email",
        :phone_number => "Phone Number",
        :lat_lon => "Lat Lon",
        :source => "Source",
        :status => "Status"
      )
    ])
  end

  it "renders a list of feedbacks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lat Lon".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
