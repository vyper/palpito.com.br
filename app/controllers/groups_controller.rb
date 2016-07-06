class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_common

  respond_to :html

  def index
    @my_groups = current_user.my_groups.includes(:championship)
    @members   = current_user.members.where.not(group: @my_groups.map(&:id))
    respond_with @my_groups
  end

  def new
    @my_group = current_user.my_groups.new
    respond_with @my_group
  end

  def create
    result = CreateGroup.call(params: group_params, user: current_user)
    @my_group = result.group

    if result.success?
      flash[:notice] = "Seu grupo #{@my_group} foi criado com sucesso"
    end

    respond_with @my_group, location: groups_path
  end

  def edit
    respond_with @my_group
  end

  def update
    flash[:notice] = "O grupo #{@my_group} foi alterado com sucesso" if @my_group.update(group_params)
    respond_with @my_group, location: groups_path
  end

  def classify
    if ClassifyGroupWorker.perform_async(@my_group.id)
      flash[:notice] = "O recálculo do ranking do #{@my_group} foi solicitado com sucesso, aguarde alguns instantes e atualize a página! (:"
    end

    respond_with @my_group, location: bets_path
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
