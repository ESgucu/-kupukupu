class MembershipsController < ApplicationController
  def index
    @memberships = Membership.where(user: current_user, group: @group)
    @group = Group.find(params[:group_id])
    @groups = Group.where(user:current_user)
  end

  def new
    @group = Group.find(params[:group_id])
    @membership = Membership.new
    redirect_to group_path(@group) unless Membership.where(user: current_user, group: @group).empty?

    # if current user is not a membership of the group do:
    creator = current_user.id == @group.user_id
    invitation = params[:inv] == @group.inv_code
    unless creator || invitation
      redirect_to group_path(@group)
    end
  end

    def create
    @membership = Membership.new(membership_params)
    if @group.memberships.where(user_id: current_user.id).exists?
      @membership.user_id = membership_params[:user_id]
    else
      @membership.user = current_user
    end
    @membership.save
    redirect_to group_membership_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @membership = Membership.find(params[:id])
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to group_path(@membership.group), notice: 'Membership was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def membership_params
    params.require(:membership).permit(:departure, :travel_date, :return_date, :group_id, :user_id)
  end

end
