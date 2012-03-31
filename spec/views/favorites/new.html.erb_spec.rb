require 'spec_helper'

describe "favorites/new.html.erb" do
  before(:each) do
    assign(:favorite, stub_model(Favorite,
      :user_id => 1,
      :course_id => 1
    ).as_new_record)
  end

  it "renders new favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => favorites_path, :method => "post" do
      assert_select "input#favorite_user_id", :name => "favorite[user_id]"
      assert_select "input#favorite_course_id", :name => "favorite[course_id]"
    end
  end
end
