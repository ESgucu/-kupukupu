class GroupsController < ApplicationController
  def index
    @memberships = Membership.where(user: current_user)
  end

  def new
    @group = Group.new
    @user = current_user
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    @membership.user = current_user
    @membership.group = @group
    if @group.save
      if @membership.save
        redirect_to group_memberships_path(group_id: @group.id), notice: 'Group was successfully created. Now you can update additional details.'
      else
        render :new
      end
    else
      render :new
    end
  end

  # def edit
  #   @group = Group.find(params[:id])
  #   @membership =
  # end

  # def update
  #   @group = Group.find(params[:id])
  #   if @group.update(group_params)
  #     redirect_to group_path(@group)
  #   else
  #     render :edit
  #   end
  # end

  def show

  end

  def group_params
    params.require(:group).permit(:name, :inv_code)
  end

  def membership_params
    params.require(:group).permit(:group, :user)
  end
end
