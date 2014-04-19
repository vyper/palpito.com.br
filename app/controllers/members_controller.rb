class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_common

  respond_to :html

  def index
    @members = @group.members
    respond_with @members
  end

private
  def set_common
    @group = current_user.my_groups.find(params[:group_id])
  end
end