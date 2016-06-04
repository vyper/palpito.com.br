class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_my_group, except: :bets

  respond_to :html

  def index
    @members = @group.members
    respond_with @members
  end

  def new
    @member = MemberForm.new(group: @group)
    respond_with @member
  end

  def invite
    @member = MemberForm.new(member_params)
    result  = InviteMember.call(member: @member)

    if result.success?
      @member = result.member
      flash[:notice] = "Você convidou #{@member.email} com sucesso"
    end

    respond_with @member, location: group_members_path(@group)
  end

  def destroy
    @member = @group.members.find(params[:id])
    flash[:notice] = "Você removeu o #{@member.email} com sucesso" if @member.destroy

    respond_with @member, location: group_members_path(@group)
  end

  def bets
    # TODO choose better way
    request.variant = :mobile if browser.mobile?

    @group   = current_user.groups.find(params[:group_id])
    @member  = @group.members.find(params[:member_id])
    @members = @group.members.joins(:user).active.merge(User.confirmed).order(points: :desc)
    @week    = WeekNavigation.new(@group.championship, params[:week])

    @bets   = @member.user.bets.
                joins(game: :championship).
                includes(game: [:team_home, :team_away, :championship]).
                merge(Game.played).
                where(
                  games: { played_at: @week.to_range, championship_id: @group.championship_id }
                ).
                order('"games"."played_at" ASC')

    respond_with @bets
  end

private
  def set_my_group
    @group = current_user.my_groups.find(params[:group_id])
  end

  def member_params
    params.require(:member_form).permit(:email).merge(group: @group)
  end
end
