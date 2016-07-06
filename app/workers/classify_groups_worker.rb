class ClassifyGroupsWorker
  include Sidekiq::Worker

  def perform
    groups.each do |group_id|
      ClassifyGroupWorker.perform_async(group_id)
    end
  end

  private

  def groups
    Group.joins(:championship).merge(Championship.running).pluck(:id)
  end
end
