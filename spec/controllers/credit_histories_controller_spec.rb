require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CreditHistoriesController do

  # This should return the minimal set of attributes required to create a valid
  # CreditHistory. As you add validations to CreditHistory, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all credit_histories as @credit_histories" do
      credit_history = CreditHistory.create! valid_attributes
      get :index
      assigns(:credit_histories).should eq([credit_history])
    end
  end

  describe "GET show" do
    it "assigns the requested credit_history as @credit_history" do
      credit_history = CreditHistory.create! valid_attributes
      get :show, :id => credit_history.id.to_s
      assigns(:credit_history).should eq(credit_history)
    end
  end

  describe "GET new" do
    it "assigns a new credit_history as @credit_history" do
      get :new
      assigns(:credit_history).should be_a_new(CreditHistory)
    end
  end

  describe "GET edit" do
    it "assigns the requested credit_history as @credit_history" do
      credit_history = CreditHistory.create! valid_attributes
      get :edit, :id => credit_history.id.to_s
      assigns(:credit_history).should eq(credit_history)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CreditHistory" do
        expect {
          post :create, :credit_history => valid_attributes
        }.to change(CreditHistory, :count).by(1)
      end

      it "assigns a newly created credit_history as @credit_history" do
        post :create, :credit_history => valid_attributes
        assigns(:credit_history).should be_a(CreditHistory)
        assigns(:credit_history).should be_persisted
      end

      it "redirects to the created credit_history" do
        post :create, :credit_history => valid_attributes
        response.should redirect_to(CreditHistory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved credit_history as @credit_history" do
        # Trigger the behavior that occurs when invalid params are submitted
        CreditHistory.any_instance.stub(:save).and_return(false)
        post :create, :credit_history => {}
        assigns(:credit_history).should be_a_new(CreditHistory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CreditHistory.any_instance.stub(:save).and_return(false)
        post :create, :credit_history => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested credit_history" do
        credit_history = CreditHistory.create! valid_attributes
        # Assuming there are no other credit_histories in the database, this
        # specifies that the CreditHistory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CreditHistory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => credit_history.id, :credit_history => {'these' => 'params'}
      end

      it "assigns the requested credit_history as @credit_history" do
        credit_history = CreditHistory.create! valid_attributes
        put :update, :id => credit_history.id, :credit_history => valid_attributes
        assigns(:credit_history).should eq(credit_history)
      end

      it "redirects to the credit_history" do
        credit_history = CreditHistory.create! valid_attributes
        put :update, :id => credit_history.id, :credit_history => valid_attributes
        response.should redirect_to(credit_history)
      end
    end

    describe "with invalid params" do
      it "assigns the credit_history as @credit_history" do
        credit_history = CreditHistory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CreditHistory.any_instance.stub(:save).and_return(false)
        put :update, :id => credit_history.id.to_s, :credit_history => {}
        assigns(:credit_history).should eq(credit_history)
      end

      it "re-renders the 'edit' template" do
        credit_history = CreditHistory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CreditHistory.any_instance.stub(:save).and_return(false)
        put :update, :id => credit_history.id.to_s, :credit_history => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested credit_history" do
      credit_history = CreditHistory.create! valid_attributes
      expect {
        delete :destroy, :id => credit_history.id.to_s
      }.to change(CreditHistory, :count).by(-1)
    end

    it "redirects to the credit_histories list" do
      credit_history = CreditHistory.create! valid_attributes
      delete :destroy, :id => credit_history.id.to_s
      response.should redirect_to(credit_histories_url)
    end
  end

end