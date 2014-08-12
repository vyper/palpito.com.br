class ClassifyGroupWorker
  include Sidekiq::Worker

  def perform(group_id)
    group = Group.find(group_id)

    # TODO: simplify this query +_+
    members = group.members.
                select("members.user_id, members.id, sum(bets.points) as points").
                joins(user: { bets: { game: :championship } }).
                joins(:group).
                where("games.played_at < ?", DateTime.now.in_time_zone).
                where("games.championship_id = groups.championship_id").
                group("members.user_id, members.id")

    members.each do |member|
      Member.find(member.id).update points: member.points || 0
    end
  end
end
