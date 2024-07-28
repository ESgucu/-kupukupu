class GroupsController < ApplicationController
  def index
    @memberships = Membership.where(user:current_user)
    @groups = Group.where()
  end

  def show
    @group = Group.find(params[:id])
    @memberships = Membership.where(group:@group)
    @membership = Membership.where(user:current_user, group:@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save!
    redirect_to new_group_membership_path(@group)
  end

  def update

  end

  def edit

  end

  private

  def group_params
    params.require(:group).permit(:name, :inv_code, :user_id)
  end

  def group_params_to_update
    params.require(:group).permit(:name)
  end

end
