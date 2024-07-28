class MembershipsController < ApplicationController
  def index

  end

  def new
    @group = Group.find(params[:group_id])
    @membership = Membership.new
    @count = Membership.where(group:@group).count
  end

  def create
    @membership = Membership.new(membership_params)
    @group = Group.find(params[:group_id])
    @count = Membership.where(group:@group).count
    @membership.group = @group
    if @count == 0
      @membership.user_id = current_user.id
    else
      @inv_code = @group.inv_code

      @user = User.new(params[:name])
      @user.save!
      @membership.user= @user
    end
    @membership.save!
    redirect_to group_membership_path(@group,@membership )
  end

  def show
    @group = Group.find(params[:group_id])
    @membership = Membership.find(params[:id])
    @memberships = Membership.where(group:@group)
  end

  def destroy

  end

  def membership_params
    params.require(:membership).permit( :departure, :travel_date, :return_date)
  end
end
