class EntitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @group = Group.find(params[:group_id])
    @entities = @group.entities.order('created_at DESC')
  end

  def new
    @entity = Entity.new
    @group = Group.find(params[:group_id])
    @groups = Group.where(user_id: current_user.id)
  end

  def create
    @entity = Entity.new(entity_params)
    @group = Group.find(params[:group].to_i)
    @entity.groups << @group

    authorize! :create, @entity

    if @entity.save
      flash[:notice] = 'Transaction created successfully'
      redirect_to group_entities_path(group_id: @group.id)
    else
      flash[:alert] = @entity.errors.full_messages.join(', ')
      redirect_to new_group_entity_path(@group.id)
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount).merge(user_id: current_user.id)
  end
end
