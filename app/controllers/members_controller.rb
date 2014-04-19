class MembersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_my_group

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
    result  = InviteMember.perform(member: @member)

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

private
  def set_my_group
    @group = current_user.my_groups.find(params[:group_id])
  end

  def member_params
    params.require(:member_form).permit(:email).merge(group: @group)
  end
end