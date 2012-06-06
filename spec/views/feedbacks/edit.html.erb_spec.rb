require 'spec_helper'

describe "feedbacks/edit.html.erb" do
  before(:each) do
    @feedback = assign(:feedback, stub_model(Feedback,
      :user_id => 1,
      :content => "MyString",
      :email => "MyString",
      :phone_number => "MyString",
      :lat_lon => "MyString",
      :source => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feedbacks_path(@feedback), :method => "post" do
      assert_select "input#feedback_user_id", :name => "feedback[user_id]"
      assert_select "input#feedback_content", :name => "feedback[content]"
      assert_select "input#feedback_email", :name => "feedback[email]"
      assert_select "input#feedback_phone_number", :name => "feedback[phone_number]"
      assert_select "input#feedback_lat_lon", :name => "feedback[lat_lon]"
      assert_select "input#feedback_source", :name => "feedback[source]"
      assert_select "input#feedback_status", :name => "feedback[status]"
    end
  end
end
