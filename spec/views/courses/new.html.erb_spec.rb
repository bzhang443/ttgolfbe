require 'spec_helper'

describe "courses/new.html.erb" do
  before(:each) do
    assign(:course, stub_model(Course,
      :club_id => 1,
      :name => "MyString",
      :designer => "MyString",
      :description => "MyText",
      :yards => 1,
      :holes => 1,
      :group_id => 1
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_club_id", :name => "course[club_id]"
      assert_select "input#course_name", :name => "course[name]"
      assert_select "input#course_designer", :name => "course[designer]"
      assert_select "textarea#course_description", :name => "course[description]"
      assert_select "input#course_yards", :name => "course[yards]"
      assert_select "input#course_holes", :name => "course[holes]"
      assert_select "input#course_group_id", :name => "course[group_id]"
    end
  end
end
