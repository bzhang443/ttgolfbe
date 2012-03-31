require 'spec_helper'

describe "prices/index.html.erb" do
  before(:each) do
    assign(:prices, [
      stub_model(Price,
        :course_id => 1,
        :time_slot => "Time Slot",
        :price => "9.99",
        :agent_id => 1
      ),
      stub_model(Price,
        :course_id => 1,
        :time_slot => "Time Slot",
        :price => "9.99",
        :agent_id => 1
      )
    ])
  end

  it "renders a list of prices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Time Slot".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
