require 'spec_helper'

describe "areas/edit.html.erb" do
  before(:each) do
    @area = assign(:area, stub_model(Area,
      :name => "MyString",
      :level => 1,
      :upper_area => 1
    ))
  end

  it "renders the edit area form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => areas_path(@area), :method => "post" do
      assert_select "input#area_name", :name => "area[name]"
      assert_select "input#area_level", :name => "area[level]"
      assert_select "input#area_upper_area", :name => "area[upper_area]"
    end
  end
end
