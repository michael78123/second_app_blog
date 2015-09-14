class GroupsController < ApplicationController
  def index
    flash[:notice] = "good morning!"
    flash[:alert] = "time to sleep!"
    flash[:warning] = "warning message!"
  end
end
