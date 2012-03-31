require 'spec_helper'

describe "agents/edit.html.erb" do
  before(:each) do
    @agent = assign(:agent, stub_model(Agent,
      :name => "MyString",
      :telephone => "MyString"
    ))
  end

  it "renders the edit agent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => agents_path(@agent), :method => "post" do
      assert_select "input#agent_name", :name => "agent[name]"
      assert_select "input#agent_telephone", :name => "agent[telephone]"
    end
  end
end
