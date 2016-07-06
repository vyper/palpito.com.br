class MemberController < ApplicationController
  before_action :authenticate_user!
  before_action :set_common

  respond_to :html

  def accept
    if @member.active!
      flash[:notice] = "Você aceitou o convite para o #{@group}! Boa sorte!"
    end

    respond_with @member, location: groups_path
  end

  def destroy
    if @member.destroy
      flash[:notice] = "Você saiu do #{@group}! );"
    end

    respond_with @member, location: groups_path
  end

private
  def set_common
    @group  = current_user.groups.find(params[:group_id])
    @member = current_user.members.where(group_id: @group.id).first
  end

  def member_params
    params.require(:member_form).permit(:email).merge(group: @group)
  end
end