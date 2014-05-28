class TeamsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_common, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @teams = Team.all
    respond_with @teams
  end

  def new
    @team = Team.new
    respond_with @team
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      flash[:notice] = "Time '#{@team}' salvo com sucesso"
    end

    respond_with @team, location: teams_path
  end

  def edit
    respond_with @team
  end

  def update
    if @team.update(team_params)
      flash[:notice] = "Time '#{@team}' salvo com sucesso"
    end

    respond_with @team, location: teams_path
  end

  def destroy
    if @team.destroy
      flash[:notice] = "Time excluído com sucesso"
    end

    respond_with @team, location: teams_path
  end

private
  def set_common
    @team = Team.where(id: params[:id]).first!
  end

  def team_params
    params.require(:team).permit(:name, :short_name, :image)
  end
end
