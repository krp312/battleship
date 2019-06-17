**Setup**

1. Clone or download this repo.
2. Navigate to the root directly and run `bundle install`.
3. Run `bin/rails db:setup`.
4. Visit `localhost:3000` with two different browsers (or the same browser, but with one window in "private" mode).

**Tests**

To run tests, run `rspec`. If tests fail, please try `bin/rails db:migrate:reset db:seed` followed by `rspec`.

**New Game**

Please follow steps 3 and 4 from "Setup".

**Gameplay Notes**
* Player One's browser will display _Ready to Move_.
* Player Two's browser will display _Please Wait_.
* Blue square: An unrevealed tile that can be played.
* Red square: A successful hit on a section of an opposing ship.
* Gray square: A miss.
* Seventeen hits results in a win ([Battleship ship sizes](https://en.wikipedia.org/wiki/Battleship_(game)#Description)).
