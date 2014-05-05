class UpdateGame
  include Interactor::Organizer

  organize PersistGame, ScheduleGameClassify
end
