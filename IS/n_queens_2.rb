require 'pry'

class King
  attr_reader :harem, :harem_size, :queens

  def initialize(size)
    @harem = Array.new(size) { Array.new(size) }
    @harem_size = size
    @queens = Array.new(size)

    place_queens_at_start
    calculate_collisions
  end

  def satisfy_queens
    moves = 1
    loop do
      # print_harem

      break if queens.all?(&:satisfied?)

      queen_to_move = queens_with_max_conflicts.sample

      new_column, count = column_and_count_of_least_collisions_for_row(queen_to_move)
      old_column        = queen_to_move.col

      row                    = queen_to_move.row
      harem[row][old_column] = nil
      harem[row][new_column] = queen_to_move

      queens_that_collide_with(row, old_column).each { |queen| queen.collisions -= 1 }

      queen_to_move.col = new_column
      queen_to_move.collisions = count

      queens_that_collide_with(row, new_column).each { |queen| queen.collisions += 1 }

      break if queens.all?(&:satisfied?)

      moves += 1
    end
    "The king finally satisfied all the queens in #{moves} moves."
  end

  private

  def queens_with_max_conflicts
    max_conflicts = -1
    max_conflict_queens = []

    queens.each do |queen|
      max_conflict_queens <<  queen if queen.collisions == max_conflicts

      if queen.collisions > max_conflicts
        max_conflict_queens = [queen]
        max_conflicts = queen.collisions
      end
    end

    max_conflict_queens
  end

  def place_queens_at_start
    (0...harem_size).each do |i|
      y = rand(0...harem_size)
      queens[i] = harem[i][y] = Queen.new(i, y)
    end
  end

  def column_and_count_of_least_collisions_for_row(queen, initialization = false)
    min_collision_count, indexes = 1.0/0.0, [] # Infinity

    col_to_explore = (0...harem_size).to_a
    col_to_explore.delete(queen.col)

    col_to_explore.each do |col|
      collision_count = queens_that_collide_with(queen.row, col, initialization).count

      # return [col, 0] if collision_count.zero? # why do I need to check the rest, saves a lot of computation

      indexes << col if collision_count == min_collision_count

      if collision_count < min_collision_count
        min_collision_count = collision_count
        indexes             = [col]
      end
    end

    [indexes.sample, min_collision_count]
  end

  def queens_that_collide_with(row, col, initializing = false)
    queens_in_collision = []

    # collisions in the column
    # wont go further than the current row if initializing the harem
    (0...row).each                { |row| queens_in_collision << harem[row][col] if harem[row][col] }
    # move on from the current row forward a.k.a dont count the queen we want to find the collisions for
    ((row + 1)...harem_size).each { |row| queens_in_collision << harem[row][col] if harem[row][col] } unless initializing

    # collisions in the diagonals
    step = 1
    # checking only the rows preceeding the current `row` as only those have been populated at initialization
    while row - step >= 0
      # `col- step` for the second diagonal, `col + step` for the main
      queens_in_collision << harem[row - step][col - step] if col - step >= 0         && harem[row - step][col - step]
      queens_in_collision << harem[row - step][col + step] if col + step < harem_size && harem[row - step][col + step]

      step += 1
    end

    step = 1
    unless initializing
      while row + step < harem_size
        # `row + step` for the second diagonal, `row - step` for the main
        queens_in_collision << harem[row + step][col - step] if col - step >= 0         && harem[row + step][col - step]
        queens_in_collision << harem[row + step][col + step] if col + step < harem_size && harem[row + step][col + step]

        step += 1
      end
    end

    queens_in_collision
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

  def calculate_collisions
    queens.each { |queen| queen.collisions =  queens_that_collide_with(queen.row, queen.col).count }
  end
end

class Queen
  attr_accessor :row, :col, :collisions

  def initialize(row, col)
    @row, @col = row, col
    @collisions = 0
  end

  def satisfied?
    collisions == 0
  end
end

module Puzzle
  def self.solve
    print 'Enter number of queens (n > 3): '
    n = gets.to_i

    p King.new(n).satisfy_queens
  end
end

Puzzle::solve
