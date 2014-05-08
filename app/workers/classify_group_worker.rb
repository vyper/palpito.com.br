class ClassifyGroupWorker
  include Sidekiq::Worker

  def perform(group_id)
    group = Group.find(group_id)

    # TODO: simplify this query +_+
    members = group.members.
                select("members.user_id, members.id, sum(bets.points) as points").
                includes(:user).
                joins(user: { bets: :game }).
                where("games.played_at < ?", DateTime.now.in_time_zone).
                where("bets.points is not null").
                group("members.user_id, members.id")

    members.each do |member|
      Member.find(member.id).update points: member.points
    end
  end
end
