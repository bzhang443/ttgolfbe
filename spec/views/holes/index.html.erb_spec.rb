require 'spec_helper'

describe "holes/index.html.erb" do
  before(:each) do
    assign(:holes, [
      stub_model(Hole,
        :course_id => 1,
        :number => 1,
        :par => 1,
        :yard_black => 1,
        :yard_gold => 1,
        :yard_blue => 1,
        :yard_white => 1,
        :yard_red => 1,
        :map_id => 1
      ),
      stub_model(Hole,
        :course_id => 1,
        :number => 1,
        :par => 1,
        :yard_black => 1,
        :yard_gold => 1,
        :yard_blue => 1,
        :yard_white => 1,
        :yard_red => 1,
        :map_id => 1
      )
    ])
  end

  it "renders a list of holes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
