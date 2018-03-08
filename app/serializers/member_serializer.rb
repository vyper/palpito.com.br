class MemberSerializer < ActiveModel::Serializer
  belongs_to :user

  attributes :points
end
