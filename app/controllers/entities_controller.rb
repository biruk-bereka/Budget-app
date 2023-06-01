class EntitiesController < ApplicationController
    before_action :authenticate_user!
    def index
        @group = Group.find(params[:group_id])
        @entities = @group.entities.order('created_at DESC')
    end

    def new
        @entity = Entity.new
        @group = Group.find(params[:group_id])
    end

    def create
        @entity = Entity.new(entity_params)
        @group = Group.find(params[:group_id])
        @entity.groups << @group

        authorize! :create, @entity

        if @entity.save
            redirect_to group_entities_path
        else
            render 'new'
        end
    end

    private 
    def  entity_params
        params.require(:entity).permit(:name, :amount).merge(user_id: current_user.id)
    end
end