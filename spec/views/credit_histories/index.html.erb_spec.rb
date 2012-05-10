require 'spec_helper'

describe "credit_histories/index.html.erb" do
  before(:each) do
    assign(:credit_histories, [
      stub_model(CreditHistory,
        :user_id => 1,
        :action => "Action",
        :offset => 1,
        :course_id => 1,
        :club_id => 1
      ),
      stub_model(CreditHistory,
        :user_id => 1,
        :action => "Action",
        :offset => 1,
        :course_id => 1,
        :club_id => 1
      )
    ])
  end

  it "renders a list of credit_histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Action".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
