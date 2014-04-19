class InviteMember
  include Interactor::Organizer

  organize FindOrInviteUser, InviteUserToGroup
end
