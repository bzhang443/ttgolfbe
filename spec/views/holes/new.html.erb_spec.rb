require 'spec_helper'

describe "holes/new.html.erb" do
  before(:each) do
    assign(:hole, stub_model(Hole,
      :course_id => 1,
      :number => 1,
      :par => 1,
      :yard_black => 1,
      :yard_gold => 1,
      :yard_blue => 1,
      :yard_white => 1,
      :yard_red => 1,
      :map_id => 1
    ).as_new_record)
  end

  it "renders new hole form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => holes_path, :method => "post" do
      assert_select "input#hole_course_id", :name => "hole[course_id]"
      assert_select "input#hole_number", :name => "hole[number]"
      assert_select "input#hole_par", :name => "hole[par]"
      assert_select "input#hole_yard_black", :name => "hole[yard_black]"
      assert_select "input#hole_yard_gold", :name => "hole[yard_gold]"
      assert_select "input#hole_yard_blue", :name => "hole[yard_blue]"
      assert_select "input#hole_yard_white", :name => "hole[yard_white]"
      assert_select "input#hole_yard_red", :name => "hole[yard_red]"
      assert_select "input#hole_map_id", :name => "hole[map_id]"
    end
  end
end
