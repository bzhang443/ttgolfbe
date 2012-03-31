require 'spec_helper'

describe "maps/edit.html.erb" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
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
      :url => "MyString"
    ))
  end

  it "renders the edit map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => maps_path(@map), :method => "post" do
      assert_select "input#map_lat_left_lower", :name => "map[lat_left_lower]"
      assert_select "input#map_lon_left_lower", :name => "map[lon_left_lower]"
      assert_select "input#map_lat_right_lower", :name => "map[lat_right_lower]"
      assert_select "input#map_lon_right_lower", :name => "map[lon_right_lower]"
      assert_select "input#map_lat_left_higher", :name => "map[lat_left_higher]"
      assert_select "input#map_lon_left_higher", :name => "map[lon_left_higher]"
      assert_select "input#map_lat_right_higher", :name => "map[lat_right_higher]"
      assert_select "input#map_lon_right_higher", :name => "map[lon_right_higher]"
      assert_select "input#map_dim_x", :name => "map[dim_x]"
      assert_select "input#map_dim_y", :name => "map[dim_y]"
      assert_select "input#map_url", :name => "map[url]"
    end
  end
end
