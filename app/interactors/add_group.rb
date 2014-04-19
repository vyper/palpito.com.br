class AddGroup
  include Interactor

  def perform
    group = user.my_groups.new(params)

    unless group.save
      context.fail!
    end

    context[:group] = group
  end
end
