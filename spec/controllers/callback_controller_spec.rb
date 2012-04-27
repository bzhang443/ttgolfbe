require 'spec_helper'

describe CallbackController do

  describe "GET 'sina'" do
    it "should be successful" do
      get 'sina'
      response.should be_success
    end
  end

end
