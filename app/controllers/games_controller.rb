class GamesController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_common, only: [:edit, :update, :classify, :destroy]

  respond_to :html

  def index
    @games = Game.all.includes(:team_home, :team_away, round: :championship).order(played_at: :asc)
    respond_with @games
  end

  def new
    @game = Game.new
    respond_with @game
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      flash[:notice] = "Jogo '#{@game}' salvo com sucesso"
    end

    respond_with @game, location: games_path
  end

  def edit
    respond_with @game
  end

  def update
    result = UpdateGame.perform(game: @game, params: game_params)

    if result.success?
      flash[:notice] = "Jogo '#{@game}' salvo com sucesso"
    end

    respond_with @game, location: games_path
  end

  def destroy
    if @game.destroy
      flash[:notice] = "Jogo excluído com sucesso"
    end

    respond_with @game, location: games_path
  end

private
  def set_common
    @game = Game.where(id: params[:id]).first!
  end

  def game_params
    params.require(:game).permit(:team_home_id, :team_away_id, :played_at, :round_id, :team_home_goals, :team_away_goals)
  end
end