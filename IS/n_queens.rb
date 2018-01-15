DIRECTIONS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
MOVES_UNTIL_RESTART = 100

class King
  def initialize(size)
    @harem = Array.new(size) { Array.new(size) }
    @harem_size = size
    @queens = []

    place_queens_at_random
    calculate_enemies
  end

  def satisfy_queens
    moves = 0
    restarts = 1
    loop do
      if moves > MOVES_UNTIL_RESTART
        p "-----------Limit of #{MOVES_UNTIL_RESTART} moves reached. Restart!-----------"
        moves = 0
        replace_queens

        restarts += 1
      end
      moves += 1

      print_harem
      move(most_unsatisfied_queen)
      calculate_enemies

      # DEBUG LINE
      # n = gets.to_i

      break if @queens.all? { |q| q.satisfied? }
    end
    print_harem

    "The king finally satisfied all the queens in #{moves} moves. He did that in #{restarts} tries."
  end

  private

  def harem_size
    @harem_size
  end

  def place_queens_at_random
    loop do
      x, y = Random.rand(0...harem_size), Random.rand(0...harem_size)

      unless @harem[x][y]
        @harem[x][y] = Queen.new(x,y)
        @queens << @harem[x][y]
      end

      break if @queens.size == harem_size
    end
  end

  def calculate_enemies
    (0...harem_size).each do |x|
      (0...harem_size).each do |y|
        if @harem[x][y]
          queen = @harem[x][y]
          queen.enemies = count_queens_in_sight(x,y)
        end
      end
    end
  end

  def count_queens_in_sight(x,y)
    queens_in_sight = 0

    # count the queens in the row/column
    (0...harem_size).each do |other_coord|
      queens_in_sight += 1 if @harem[x][other_coord] && other_coord != y
      queens_in_sight += 1 if @harem[other_coord][y] && other_coord != x
    end

    # starting point for the search of other queens in the main diag
    main_diag_x, main_diag_y = x, y

    while main_diag_x < harem_size && main_diag_y < harem_size
      queens_in_sight += 1 if @harem[main_diag_x][main_diag_y] && main_diag_x != x

      main_diag_x += 1
      main_diag_y += 1
    end

    main_diag_x, main_diag_y = x, y

    while main_diag_x >= 0 && main_diag_y >= 0
      queens_in_sight += 1 if @harem[main_diag_x][main_diag_y] && main_diag_x != x

      main_diag_x -= 1
      main_diag_y -= 1
    end

    # starting point for the search of other queens in the secondary diag
    sec_diag_x, sec_diag_y = x, y

    while sec_diag_x < harem_size && sec_diag_y >= 0
      queens_in_sight += 1 if @harem[sec_diag_x][sec_diag_y] && sec_diag_x != x

      sec_diag_x += 1
      sec_diag_y -= 1
    end

    sec_diag_x, sec_diag_y = x, y

    while sec_diag_x >= 0 && sec_diag_y < harem_size
      queens_in_sight += 1 if @harem[sec_diag_x][sec_diag_y] && sec_diag_x != x

      sec_diag_x -= 1
      sec_diag_y += 1
    end

    queens_in_sight
  end

  def print_harem
    (0...harem_size).each do |x|
      print '-' * (2 * harem_size + 1)
      row = ''
      (0...harem_size).each do |y|
        row += '|'
        row += @harem[x][y] ? 'Q' : ' '
      end
      print row + "|\n"
    end
    print "\n"
  end

  def move(queen)
    queen_x, queen_y = queen.coords
    loop do
      x, y = DIRECTIONS.sample
      new_x, new_y = x + queen_x, y + queen_y

      if new_x >= 0 && new_y >= 0 && new_x < harem_size && new_y < harem_size && @harem[new_x][new_y].nil?
        @harem[queen_x][queen_y] = nil

        @harem[new_x][new_y] = queen
        queen.coords = [new_x, new_y]

        break
      end
    end
  end

  def replace_queens
    (0...harem_size).each do |x|
      (0...harem_size).each do |y|
        @harem[x][y] = nil
      end
    end

    @queens = []

    place_queens_at_random
    calculate_enemies
  end

  # not sure this works 100% but there are no more crashes and a solution is found eventually
  def most_unsatisfied_queen(queens = @queens)
    max_enemies = -1
    most_unsatisfied_queens = []

    queens.each do |queen|
      if max_enemies < queen.enemies
        most_unsatisfied_queens = [queen]
      elsif max_enemies = queen.enemies
        most_unsatisfied_queens << queen
      end
    end

    whiner = most_unsatisfied_queens.sample
    return whiner unless stuck?(whiner)

    queens_that_can_move = queens.clone
    queens_that_can_move.delete(whiner)

    most_unsatisfied_queen(queens_that_can_move)
  end

  def stuck?(queen)
    x, y = queen.coords
    DIRECTIONS.each do |pair|
      inc_x, inc_y = pair
      new_x, new_y = x + inc_x, y + inc_y

      return false if new_x >= 0 && new_x < harem_size && new_y >= 0 && new_y < harem_size && @harem[new_x][new_y].nil?
    end

    true
  end
end

class Queen
  def initialize(x, y)
    @enemies = 0
    @x, @y = x, y
  end

  def enemies
    @enemies
  end

  def enemies=(count)
    @enemies = count
  end

  def satisfied?
    @enemies == 0
  end

  def coords
    [@x, @y]
  end

  def coords=(new_coords)
    @x, @y = new_coords
  end
end


module Puzzle
  def self.solve
    print 'Enter number of queens: '
    n = gets.to_i

    p King.new(n).satisfy_queens
  end
end

Puzzle::solve
