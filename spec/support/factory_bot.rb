RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.define do
  factory :square do
    position_x { rand(1..10) }
    position_y  { rand(1..10) }
  end
end