class GroupSerializer < ActiveModel::Serializer
  belongs_to :championship

  attributes :id, :name
end
