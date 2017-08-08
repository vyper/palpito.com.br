if Rails.env.development?
  Bullet.enable = true
  Bullet.rails_logger = true
  Bullet.add_footer = true
end
