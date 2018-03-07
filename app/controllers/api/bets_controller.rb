class Api::BetsController < ::BetsController
  def index
    # TODO Improve and TEST!!!
    respond_with(
      bets: bets.map { |bet| BetSerializer.new(bet) },
      week_navigation: {
        week: navigation.week,
        start_at: navigation.start.strftime("%d/%m"),
        finish_at: navigation.finish.strftime("%d/%m"),
        previous_link: navigation.previous? ? api_bets_url(day: navigation.previous, format: :json) : nil,
        next_link: navigation.next? ? api_bets_url(day: navigation.next, format: :json) : nil,
      }
    )
  end
end
