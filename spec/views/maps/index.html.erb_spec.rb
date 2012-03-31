require 'spec_helper'

describe "maps/index.html.erb" do
  before(:each) do
    assign(:maps, [
      stub_model(Map,
        :lat_left_lower => "9.99",
        :lon_left_lower => "9.99",
        :lat_right_lower => "9.99",
        :lon_right_lower => "9.99",
        :lat_left_higher => "9.99",
        :lon_left_higher => "9.99",
        :lat_right_higher => "9.99",
        :lon_right_higher => "9.99",
        :dim_x => 1,
        :dim_y => 1,
        :url => "Url"
      ),
      stub_model(Map,
        :lat_left_lower => "9.99",
        :lon_left_lower => "9.99",
        :lat_right_lower => "9.99",
        :lon_right_lower => "9.99",
        :lat_left_higher => "9.99",
        :lon_left_higher => "9.99",
        :lat_right_higher => "9.99",
        :lon_right_higher => "9.99",
        :dim_x => 1,
        :dim_y => 1,
        :url => "Url"
      )
    ])
  end

  it "renders a list of maps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
