class RoundsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_common, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @rounds = Round.all
    respond_with @rounds
  end

  def new
    @round = Round.new
    respond_with @round
  end

  def create
    @round = Round.new(round_params)

    if @round.save
      flash[:notice] = "Rodada '#{@round}' salva com sucesso"
    end

    respond_with @round, location: rounds_path
  end

  def edit
    respond_with @round
  end

  def update
    if @round.update(round_params)
      flash[:notice] = "Campeonato '#{@round}' salvo com sucesso"
    end

    respond_with @round, location: rounds_path
  end

  def destroy
    if @round.destroy
      flash[:notice] = "Rodada excluída com sucesso"
    end

    respond_with @round, location: rounds_path
  end

private
  def set_common
    @round = Round.where(id: params[:id]).first!
  end

  def round_params
    params.require(:round).permit(:name, :championship_id)
  end
end
