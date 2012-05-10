class CreditHistoriesController < ApplicationController
  # GET /credit_histories
  # GET /credit_histories.json
  def index
    @credit_histories = CreditHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credit_histories }
    end
  end

  # GET /credit_histories/1
  # GET /credit_histories/1.json
  def show
    @credit_history = CreditHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit_history }
    end
  end

  # GET /credit_histories/new
  # GET /credit_histories/new.json
  def new
    @credit_history = CreditHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit_history }
    end
  end

  # GET /credit_histories/1/edit
  def edit
    @credit_history = CreditHistory.find(params[:id])
  end

  # POST /credit_histories
  # POST /credit_histories.json
  def create
    @credit_history = CreditHistory.new(params[:credit_history])

    respond_to do |format|
      if @credit_history.save
        format.html { redirect_to @credit_history, notice: 'Credit history was successfully created.' }
        format.json { render json: @credit_history, status: :created, location: @credit_history }
      else
        format.html { render action: "new" }
        format.json { render json: @credit_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /credit_histories/1
  # PUT /credit_histories/1.json
  def update
    @credit_history = CreditHistory.find(params[:id])

    respond_to do |format|
      if @credit_history.update_attributes(params[:credit_history])
        format.html { redirect_to @credit_history, notice: 'Credit history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credit_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_histories/1
  # DELETE /credit_histories/1.json
  def destroy
    @credit_history = CreditHistory.find(params[:id])
    @credit_history.destroy

    respond_to do |format|
      format.html { redirect_to credit_histories_url }
      format.json { head :no_content }
    end
  end
end
