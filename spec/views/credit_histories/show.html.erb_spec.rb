require 'spec_helper'

describe "credit_histories/show.html.erb" do
  before(:each) do
    @credit_history = assign(:credit_history, stub_model(CreditHistory,
      :user_id => 1,
      :action => "Action",
      :offset => 1,
      :course_id => 1,
      :club_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Action/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
