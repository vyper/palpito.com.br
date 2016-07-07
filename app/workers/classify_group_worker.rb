class ClassifyGroupWorker
  include Sidekiq::Worker

  def perform(group_id, day = Time.current)
    group = Group.find(group_id)

    # TODO: IMPROVE and simplify this query +_+
    #       But in the near future (I hope) this code will change
    #       also the approach to update bets, members and groups!
    rows = group.members.
             select("members.user_id, members.id, coalesce(sum(bets.points), 0) as points").
             joins(user: { bets: { game: :championship } }).
             joins(:group).
             merge(Game.played_until(day)).
             where("games.championship_id = groups.championship_id").
             group("members.user_id, members.id")

    rows.sort_by(&:points).reverse.each_with_index do |row, i|
      member = Member.find(row.id)
      member.rank_for! day, points: row.points, position: (i + 1)
    end
  end
end
