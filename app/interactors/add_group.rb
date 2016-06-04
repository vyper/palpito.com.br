class AddGroup
  include Interactor

  def call
    group = context.user.my_groups.new(context.params)

    unless group.save
      context.fail!
    end

    context.group = group
  end
end
