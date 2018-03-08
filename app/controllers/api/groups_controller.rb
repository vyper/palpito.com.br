class Api::GroupsController < ::ApplicationController
  respond_to :json

  def index
    @groups = current_user.groups.joins(:championship).order('championships.name, groups.name')
    respond_with(groups: @groups.map { |group| GroupSerializer.new(group) })
  end
end
