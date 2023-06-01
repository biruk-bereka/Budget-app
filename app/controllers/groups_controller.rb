class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.includes(entity_groups: :entity).where(user: current_user)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    authorize! :create, @group

    if @group.save
      flash[:notice] = 'Category created successfully'
      redirect_to groups_path
    else
      flash[:alert] = @group.errors.full_messages.join(', ')
      redirect_to new_group_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon).merge(user_id: current_user.id)
  end
end
