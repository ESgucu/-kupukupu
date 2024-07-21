class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
    @memberships = Membership.where(user: current_user, group: @group)
  end

  def show
    @group = Group.find(params[:id])
    @membership = Membership.where(user: current_user, group: @group)
    @memberships = Membership.where(group: @group)
  end

  def new
    @group = Group.new

  end

  def create
    @group = Group.new(group_params)
    @group.save
    # @membership = Membership.new(user: current_user, group: @group)
    # @membership.save
    redirect_to new_group_membership_path(@group)
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params_to_update)
      redirect_to @group, notice: 'Group name was successfully updated.'
    else
      render :edit
    end
  end

  def edit
    @group = Group.find(params[:id])

  end

  private

  def group_params
    params.require(:group).permit(:name, :inv_code, :usercurrent_user)
  end

  def group_params_to_update
    params.require(:group).permit(:name)
  end

end
