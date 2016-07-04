require 'nokogiri'
require 'open-uri'

namespace :api do
  namespace :championship do
    desc "Update games"
    task :update, [:day] => [:environment] do |t, args|
      default_logo = File.open(Rails.root.join('app', 'assets', 'images', 'default-logo.png'))
      game_date = args[:day].present? ? Time.zone.parse(args[:day]) : Time.zone.now

      puts "[START #{Time.now.in_time_zone}] api:championship:update => date: #{game_date}"

      championships = Championship.where("? between started_at and finished_at", game_date)
      championships.each do |championship|
        print "championship: #{championship}: "
        url = championship.url + "#{championship.url.include?("?") ? "&" : "?"}date=#{game_date.strftime("%Y%m%d")}"
        doc = Nokogiri::HTML(open(url))

        games = doc.css(".score-box")
        games.each do |game|
          game_time = game.css(".game-info .time")

          team_home_name = game.css(".team-name")[0].text.strip
          team_away_name = game.css(".team-name")[1].text.strip

          team_home_goals = game.css(".team-score span")[0].text.gsub(/\([0-9]+\) ?/, "")
          team_away_goals = game.css(".team-score span")[1].text.gsub(/\([0-9]+\) ?/, "")

          team_home = Team.where(external_id: team_home_name).first_or_create(name: team_home_name, short_name: team_home_name[0..2].upcase, image: default_logo)
          team_away = Team.where(external_id: team_away_name).first_or_create(name: team_away_name, short_name: team_away_name[0..2].upcase, image: default_logo)

          game_external_id =  game.css(".score").first.attributes["data-gameid"].value
          game = Game.where(external_id: game_external_id).
                      first_or_create(team_home: team_home, team_away: team_away, championship: championship)

          game.team_home = team_home
          game.team_away = team_away
          game.team_home_goals = team_home_goals
          game.team_away_goals = team_away_goals

          if !(game_time.text =~ /LIVE|FT|AET/)
            played_at = game_time.first.attributes['data-time'].value
            game.played_at = Time.zone.parse(played_at)
          end

          print '.'
          game.save

          ClassifyGameWorker.perform_async game.id
        end
        puts

        puts "[FINISH #{Time.now.in_time_zone}] api:championship:update => date: #{game_date}"
      end
    end
  end
end
