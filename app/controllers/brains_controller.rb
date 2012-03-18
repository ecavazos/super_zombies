class BrainsController < ApplicationController
  def index
    @brains = Brain.all
  end

  def destroy
    Brain.find(params[:id]).destroy
    redirect_to brains_path, :notice => 'One less brain to worry about.'
  end
end
