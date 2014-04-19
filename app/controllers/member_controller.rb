class MemberController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_group

  respond_to :html

  def accept
    @member = current_user.members.where(group_id: @group.id).first
    flash[:notice] = "Você aceitou o convite para o #{@group}! Boa sorte!" if @member.active!
    respond_with @member, location: groups_path
  end

  def destroy
    @member = current_user.members.where(group_id: @group.id).first
    flash[:notice] = "Você saiu do #{@group}! );" if @member.destroy
    respond_with @member, location: groups_path
  end

private
  def set_group
    @group = current_user.groups.find(params[:group_id])
  end

  def member_params
    params.require(:member_form).permit(:email).merge(group: @group)
  end
end