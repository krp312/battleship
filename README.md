**Setup**

1. Notable requirements:

* Bundler 1.16.6
* Postgres
* Rails 5
* Ruby 2.5.1

2. Clone or download this repo.
3. Navigate to the root directory and run `bundle install`.
4. `bin/rails db:setup`
5. `bin/rails server`
6. Visit `localhost:3000` with two different browsers (or the same browser, but with one window in _private_ mode).

**Tests**

To run tests, run `rspec`. If tests fail, try `bin/rails db:setup` followed by `rspec`.

**New Game**

Follow steps 4-6 from _Setup_.

**Gameplay Notes**

* When the game starts, Player One will receive the first move.
* Blue square: An unrevealed tile that can be played.
* Red square: A successful hit on a section of an opposing ship.
* Gray square: A miss.
* Seventeen hits results in a win ([Battleship ship sizes](https://en.wikipedia.org/wiki/Battleship_(game)#Description)).
