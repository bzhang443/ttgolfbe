require 'spec_helper'

describe "agents/index.html.erb" do
  before(:each) do
    assign(:agents, [
      stub_model(Agent,
        :name => "Name",
        :telephone => "Telephone"
      ),
      stub_model(Agent,
        :name => "Name",
        :telephone => "Telephone"
      )
    ])
  end

  it "renders a list of agents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Telephone".to_s, :count => 2
  end
end
