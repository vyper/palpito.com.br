class BetCalculator
  attr_accessor :game_home_goals, :game_away_goals, :bet_home_goals, :bet_away_goals, :points

  POINTS = 10

  def initialize(options)
    @points          = options.fetch(:points, POINTS)
    @game_home_goals = options[:game_home_goals]
    @game_away_goals = options[:game_away_goals]
    @bet_home_goals  = options[:bet_home_goals]
    @bet_away_goals  = options[:bet_away_goals]
  end

  def calculate
    return nil unless goals?

    return 0 unless bet_is_correct?

    score = 0

    # home goals
    # IF(B2>B3,X-(B2-B3),X-(B3-B2))
    gh_goals = game_home_goals
    bh_goals = bet_home_goals

    if gh_goals > bh_goals
      score += points - (gh_goals - bh_goals)
    elsif gh_goals < bh_goals
      score += points - (bh_goals - gh_goals)
    else
      score += points
    end

    # away goals
    # IF(D2>D3,X-(D2-D3),X-(D3-D2))
    ga_goals = game_away_goals
    ba_goals = bet_away_goals

    if ga_goals > ba_goals
      score += points - (ga_goals - ba_goals)
    elsif ga_goals < ba_goals
      score += points - (ba_goals - ga_goals)
    else
      score += points
    end

    # Points by correct bet
    score += points

    # Points by correct score
    if game_home_goals == bet_home_goals && game_away_goals == bet_away_goals
      score += points
    end

    score
  end

  def goals?
    game_home_goals.present? && game_away_goals.present? && bet_home_goals.present? && bet_away_goals.present?
  end

  def game_home_winner?
    game_home_goals > game_away_goals
  end

  def game_away_winner?
    game_home_goals < game_away_goals
  end

  def game_tied?
    game_home_goals == game_away_goals
  end

  def bet_home_winner?
    bet_home_goals > bet_away_goals
  end

  def bet_away_winner?
    bet_home_goals < bet_away_goals
  end

  def bet_is_correct?
    game_home_winner? == bet_home_winner? &&
    game_away_winner? == bet_away_winner? &&
    game_tied? == bet_tied?
  end

  def bet_tied?
    bet_home_goals == bet_away_goals
  end
end
