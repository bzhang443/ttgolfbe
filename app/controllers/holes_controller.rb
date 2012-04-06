class HolesController < ApplicationController
  # GET /holes
  # GET /holes.json
  def index
    @holes = Hole.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @holes }
    end
  end

  # GET /holes/1
  # GET /holes/1.json
  def show
    @hole = Hole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hole }
    end
  end

  # GET /holes/new
  # GET /holes/new.json
  def new
    @hole = Hole.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hole }
    end
  end

  # GET /holes/1/edit
  def edit
    @hole = Hole.find(params[:id])
  end

  # POST /holes
  # POST /holes.json
  def create
    @hole = Hole.new(params[:hole])

    respond_to do |format|
      if @hole.save
        format.html { redirect_to @hole, notice: 'Hole was successfully created.' }
        format.json { render json: @hole, status: :created, location: @hole }
      else
        format.html { render action: "new" }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /holes/1
  # PUT /holes/1.json
  def update
    @hole = Hole.find(params[:id])

    respond_to do |format|
      if @hole.update_attributes(params[:hole])
        format.html { redirect_to @hole, notice: 'Hole was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holes/1
  # DELETE /holes/1.json
  def destroy
    @hole = Hole.find(params[:id])
    @hole.destroy

    respond_to do |format|
      format.html { redirect_to holes_url }
      format.json { head :no_content }
    end
  end
end
