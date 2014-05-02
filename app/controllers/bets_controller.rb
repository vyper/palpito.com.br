class BetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :with_groups?

  respond_to :html, :json

  def index
    @groups  = current_user.groups.order(:name)
    @members = group.members

    @bets = current_user.bets.
              joins(game: :round).
              where(
                rounds: { championship_id: group.championship_id },
                games: { played_at: week.to_range }
              ).
              order('"games"."played_at" ASC')

    respond_with @bets
  end

  def update
    @bet = current_user.bets.find(params[:id])
    @bet.update(bet_params)
    respond_with @bet
  end

private
  def with_groups?
    unless current_user.groups.count > 0
      redirect_to groups_path
    end
  end

  def week
    @week = WeekNavigation.new(group.championship, params[:week])
  end

  def group
    if params[:group_id].present?
      @group = @groups.find(params[:group_id])
      session[:group_id] = params[:group_id]
    elsif session[:group_id].present?
      @group = @groups.find(session[:group_id])
    else
      @group = @groups.first
    end

    @group
  end

  def bet_params
    params.require(:bet).permit(:team_home_goals, :team_away_goals)
  end
end
