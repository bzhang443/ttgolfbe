require 'spec_helper'

describe "credit_histories/new.html.erb" do
  before(:each) do
    assign(:credit_history, stub_model(CreditHistory,
      :user_id => 1,
      :action => "MyString",
      :offset => 1,
      :course_id => 1,
      :club_id => 1
    ).as_new_record)
  end

  it "renders new credit_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => credit_histories_path, :method => "post" do
      assert_select "input#credit_history_user_id", :name => "credit_history[user_id]"
      assert_select "input#credit_history_action", :name => "credit_history[action]"
      assert_select "input#credit_history_offset", :name => "credit_history[offset]"
      assert_select "input#credit_history_course_id", :name => "credit_history[course_id]"
      assert_select "input#credit_history_club_id", :name => "credit_history[club_id]"
    end
  end
end
