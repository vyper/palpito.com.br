class BetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :with_groups?

  respond_to :html, :json

  def index
    # TODO choose better way
    request.variant = :mobile if browser.device.mobile?

    @groups  = current_user.groups.includes(:championship).order(:name)
    @members = group.members.joins(:user).active.merge(User.confirmed).order(points: :desc)
    @bets    = current_user.bets.by_championship_in(group.championship, navigation.to_range)

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

  def navigation
    @navigation = WeekNavigation.new(championship: group.championship, day: params[:day])
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
