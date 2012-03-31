require 'spec_helper'

describe "comments/new.html.erb" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :course_id => 1,
      :user_id => 1,
      :overall => "9.99",
      :view => "9.99",
      :hardiness => "9.99",
      :design => "9.99",
      :recall => "9.99",
      :maintenance => "9.99",
      :culture => "9.99",
      :candy => "9.99",
      :facility => "9.99",
      :service => "9.99",
      :price => "9.99",
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => comments_path, :method => "post" do
      assert_select "input#comment_course_id", :name => "comment[course_id]"
      assert_select "input#comment_user_id", :name => "comment[user_id]"
      assert_select "input#comment_overall", :name => "comment[overall]"
      assert_select "input#comment_view", :name => "comment[view]"
      assert_select "input#comment_hardiness", :name => "comment[hardiness]"
      assert_select "input#comment_design", :name => "comment[design]"
      assert_select "input#comment_recall", :name => "comment[recall]"
      assert_select "input#comment_maintenance", :name => "comment[maintenance]"
      assert_select "input#comment_culture", :name => "comment[culture]"
      assert_select "input#comment_candy", :name => "comment[candy]"
      assert_select "input#comment_facility", :name => "comment[facility]"
      assert_select "input#comment_service", :name => "comment[service]"
      assert_select "input#comment_price", :name => "comment[price]"
      assert_select "input#comment_notes", :name => "comment[notes]"
    end
  end
end
