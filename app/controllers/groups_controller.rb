class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_common

  respond_to :html

  def index
    @my_groups = current_user.my_groups
    @groups    = current_user.groups
    respond_with @my_groups + @groups
  end

  def new
    @my_group = current_user.my_groups.new
    respond_with @my_group
  end

  def create
    @my_group = current_user.my_groups.new(group_params)
    flash[:notice] = "Seu grupo #{@my_group} foi criado com sucesso" if @my_group.save
    respond_with @my_group, location: groups_path
  end

  def edit
    respond_with @my_group
  end

  def update
    flash[:notice] = "O grupo #{@my_group} foi alterado com sucesso" if @my_group.update(group_params)
    respond_with @my_group, location: groups_path
  end

  def destroy
    @my_group.destroy
    flash[:notice] = "O seu grupo foi excluído com sucesso"
    respond_with @my_group
  end

private
  def set_common
    @my_group = current_user.my_groups.find(params[:id]) if params[:id]
  end

  def group_params
    params.require(:group).permit(:name, :championship_id)
  end
end
