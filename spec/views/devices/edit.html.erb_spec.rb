require 'spec_helper'

describe "devices/edit.html.erb" do
  before(:each) do
    @device = assign(:device, stub_model(Device,
      :did => "MyString",
      :model => "MyString",
      :os => "MyString",
      :version => "MyString",
      :source => "MyString",
      :token => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit device form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => devices_path(@device), :method => "post" do
      assert_select "input#device_did", :name => "device[did]"
      assert_select "input#device_model", :name => "device[model]"
      assert_select "input#device_os", :name => "device[os]"
      assert_select "input#device_version", :name => "device[version]"
      assert_select "input#device_source", :name => "device[source]"
      assert_select "input#device_token", :name => "device[token]"
      assert_select "input#device_user_id", :name => "device[user_id]"
    end
  end
end
