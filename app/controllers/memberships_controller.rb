class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all  # This retrieves all memberships
    @membership = Membership.new
    # @group = params[:group_id]
    # @membership = Membership.where(user: current_user, group: @group)
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    @membership.group_id = params[:group_id]
    @membership.user = current_user
    @group = params[:group_id]
    if @membership.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      redirect_to membership_path(@membership)
    else
      render :edit
    end
  end


  def membership_params
    params.require(:membership).permit(:departure, :travel_date, :return_date)
  end

end
