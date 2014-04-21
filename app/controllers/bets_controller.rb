class BetsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

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

private
  def week
    @week = Week.new(group.championship, params[:week])
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
end
