require 'spec_helper'

describe "clubs/new.html.erb" do
  before(:each) do
    assign(:club, stub_model(Club,
      :name => "MyString",
      :area_id => 1,
      :address => "MyString",
      :latitude => "9.99",
      :longitude => "9.99",
      :description => "MyText",
      :logo_url => "MyString",
      :telephone => "MyString",
      :active => false
    ).as_new_record)
  end

  it "renders new club form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clubs_path, :method => "post" do
      assert_select "input#club_name", :name => "club[name]"
      assert_select "input#club_area_id", :name => "club[area_id]"
      assert_select "input#club_address", :name => "club[address]"
      assert_select "input#club_latitude", :name => "club[latitude]"
      assert_select "input#club_longitude", :name => "club[longitude]"
      assert_select "textarea#club_description", :name => "club[description]"
      assert_select "input#club_logo_url", :name => "club[logo_url]"
      assert_select "input#club_telephone", :name => "club[telephone]"
      assert_select "input#club_active", :name => "club[active]"
    end
  end
end
