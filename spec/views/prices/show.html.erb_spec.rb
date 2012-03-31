require 'spec_helper'

describe "prices/show.html.erb" do
  before(:each) do
    @price = assign(:price, stub_model(Price,
      :course_id => 1,
      :time_slot => "Time Slot",
      :price => "9.99",
      :agent_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Time Slot/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
