require 'spec_helper'

describe "clubs/index.html.erb" do
  before(:each) do
    assign(:clubs, [
      stub_model(Club,
        :name => "Name",
        :area_id => 1,
        :address => "Address",
        :latitude => "9.99",
        :longitude => "9.99",
        :description => "MyText",
        :logo_url => "Logo Url",
        :telephone => "Telephone",
        :active => false
      ),
      stub_model(Club,
        :name => "Name",
        :area_id => 1,
        :address => "Address",
        :latitude => "9.99",
        :longitude => "9.99",
        :description => "MyText",
        :logo_url => "Logo Url",
        :telephone => "Telephone",
        :active => false
      )
    ])
  end

  it "renders a list of clubs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Logo Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
