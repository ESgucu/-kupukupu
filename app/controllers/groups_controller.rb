class GroupsController < ApplicationController
  def index
    # @current_membership = Membership.where(user: current_user)
    @groups = Group.all
    groups = Group.where(user: current_user)
    if current_user.group_id.nil?
      redirect_to new_group_path()
    else
      @groups = groups
    end
    # @groups = Group.where(user: current_user)
    #if not nil, show all the groups of this user
    #if not nil and only one ->  not a .each in index.
  end

  def show

  end

  def new
    @group = Group.new
    if @group
      name = params[:groupName]
      inv_code = SecureRandom.hex(10).to_s
      @group = Group.new(name:name, inv_code: inv_code, user_id: current_user.id)
    end
  end

  # def create
  # end

  # def show
  # end

  def group_params
    params.require(:group).permit(:name, :inv_code)
  end

  def membership_params
  end
end
