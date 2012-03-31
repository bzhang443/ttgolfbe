require 'spec_helper'

describe "prices/edit.html.erb" do
  before(:each) do
    @price = assign(:price, stub_model(Price,
      :course_id => 1,
      :time_slot => "MyString",
      :price => "9.99",
      :agent_id => 1
    ))
  end

  it "renders the edit price form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => prices_path(@price), :method => "post" do
      assert_select "input#price_course_id", :name => "price[course_id]"
      assert_select "input#price_time_slot", :name => "price[time_slot]"
      assert_select "input#price_price", :name => "price[price]"
      assert_select "input#price_agent_id", :name => "price[agent_id]"
    end
  end
end
