class ChampionshipsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_common, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @championships = Championship.all
    respond_with @championships
  end

  def new
    @championship = Championship.new
    respond_with @championship
  end

  def create
    @championship = Championship.new(championship_params)

    if @championship.save
      flash[:notice] = "Campeonato '#{@championship}' salvo com sucesso"
    end

    respond_with @championship, location: championships_path
  end

  def edit
    respond_with @championship
  end

  def update
    if @championship.update(championship_params)
      flash[:notice] = "Campeonato '#{@championship}' salvo com sucesso"
    end

    respond_with @championship, location: championships_path
  end

  def destroy
    if @championship.destroy
      flash[:notice] = "Campeonato excluído com sucesso"
    end

    respond_with @championship, location: championships_path
  end

private
  def set_common
    @championship = Championship.where(id: params[:id]).first!
  end

  def championship_params
    params.require(:championship).permit(:name, :url, :started_at, :finished_at)
  end
end
