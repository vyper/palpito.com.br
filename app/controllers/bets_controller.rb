class BetsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def index
    @bets = current_user.bets

    respond_with @bets
  end
end
