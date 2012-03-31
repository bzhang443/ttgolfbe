require 'spec_helper'

describe "areas/show.html.erb" do
  before(:each) do
    @area = assign(:area, stub_model(Area,
      :name => "Name",
      :level => 1,
      :upper_area => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
