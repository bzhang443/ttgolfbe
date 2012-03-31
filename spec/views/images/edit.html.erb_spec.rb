require 'spec_helper'

describe "images/edit.html.erb" do
  before(:each) do
    @image = assign(:image, stub_model(Image,
      :title => "MyString",
      :url => "MyString",
      :club_id => 1,
      :course_id => 1
    ))
  end

  it "renders the edit image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => images_path(@image), :method => "post" do
      assert_select "input#image_title", :name => "image[title]"
      assert_select "input#image_url", :name => "image[url]"
      assert_select "input#image_club_id", :name => "image[club_id]"
      assert_select "input#image_course_id", :name => "image[course_id]"
    end
  end
end
