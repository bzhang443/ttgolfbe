require 'spec_helper'

describe "clubs/show.html.erb" do
  before(:each) do
    @club = assign(:club, stub_model(Club,
      :name => "Name",
      :area_id => 1,
      :address => "Address",
      :latitude => "9.99",
      :longitude => "9.99",
      :description => "MyText",
      :logo_url => "Logo Url",
      :telephone => "Telephone",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Logo Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Telephone/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
