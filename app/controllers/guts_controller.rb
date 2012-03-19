class GutsController < ApplicationController
  def index
    @guts = Gut.all
  end

  def show
    @gut = Gut.find params[:id]
  end

  def new
    @gut = Gut.new
  end

  def create
    @gut = Gut.new params[:gut]
    if @gut.save
      redirect_to guts_path, :notice => 'Mmmmmm Guts.'
    else
      render :new
    end
  end

  def edit
    @gut = Gut.find params[:id]
  end

  def update
    @gut = Gut.find params[:id]
    if @gut.update_attributes params[:gut]
      redirect_to guts_path, :notice => 'Guts are better with hot sauce.'
    else
      render :edit
    end
  end

  def destroy
    Gut.find(params[:id]).destroy
    redirect_to guts_path, :notice => 'No guts no glory.'
  end
end
