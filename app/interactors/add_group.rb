class AddGroup
  include Interactor

  def call
    context.group = context.user.my_groups.new(context.params)

    unless context.group.save
      context.fail!
    end
  end
end
