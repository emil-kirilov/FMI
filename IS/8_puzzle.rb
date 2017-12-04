class Board
  POSSIBLE_MOVES = [[-1, 0], [0, -1], [0, 1], [1, 0]]

  def initialize(board, distance = nil)
    @board = board
    @size = board.length
    @max_i = @size - 1

    # let's remember where the 0 is
    index_of_zero = board.flatten.index(0)
    @zero_x = index_of_zero / @size
    @zero_y = index_of_zero % @size

    @distance ||= distance + 1

    @checksum = calculate_checksum
  end

  def self.generate_final_state(n)
    # generating the numbers except the 0, which stands at the lower right corner
    # split the numbers in rows
    size = Math.sqrt(n).to_i
    @@final_state = (1..n-1).each_slice(size).to_a
    # add the 0 to the final row
    @@final_state[-1] << 0

    possible_indexes = []
    (0..size - 1).each { |index| 2.times { possible_indexes << index } }

    # all the possible pair of indexes
    @@indexes = possible_indexes.permutation(2).to_a.uniq.sort

    # create a hash representing each number's indexes on the board.
    # key - number, value - indexes pair
    @@final_number_positions = @@final_state.flatten.zip(@@indexes).to_h
  end

  def self.solve_puzzle(initial_board)
    @@states = OrderedArray.new
    @@states << initial_board

    loop do
      best_state = @@states.shift
      return best_state.distance if best_state.final?

      best_state.next_states.each { |new_board| @@states << new_board }
    end
  end

  def distance
    @distance
  end

  def checksum
    @checksum
  end

  def board
    @board
  end

  def final?
    @board == @@final_state
  end

  def next_states
    new_boards = []

    POSSIBLE_MOVES.each do |step_x, step_y|
      new_board = @board.map { |row| row.clone }

      if possible_move?(step_x, step_y)
        new_board[@zero_x][@zero_y]                   = new_board[@zero_x + step_x][@zero_y + step_y]
        new_board[@zero_x + step_x][@zero_y + step_y] = 0

        new_boards << Board.new(new_board, distance)
      end
    end

    new_boards
  end

  def hash
    @board.hash
  end

  def eql?(other_board)
    @board == other_board.board
  end

  private

  def recalculate_checksum
    @checksum = calculate_checksum
  end

  def calculate_checksum
    checksum = 0

    number_positions = board.flatten.zip(@@indexes).to_h

    (0..@size**2-1).each do |number|
      x, y             = number_positions[number]
      other_x, other_y = @@final_number_positions[number]

      checksum += (x - other_x).abs + (y - other_y).abs
    end

    checksum += distance
  end

  def possible_move?(step_x, step_y)
    step_x + @zero_x >= 0 &&
      step_y + @zero_y >= 0 &&
      step_x + @zero_x <= @max_i &&
      step_y + @zero_y <= @max_i
  end

  def self.states
    @states = OrderedArray.new
  end
end

class OrderedArray
  include Enumerable

  def initialize
    @boards    = {}
    @checksums = {}
    @distances = {}
  end

  def each(&block)
    @boards.each(&block)
  end

  def <<(board)
    if @boards[board].nil?
      @checksums[board] = board.checksum
      @distances[board] = board.distance

      @boards[board] = @checksums[board] + @distances[board]
    elsif @distances[board] >= board.distance
      # this state has been reached already but it was further from the start
      # this is a better, shorter route
      @distances[board] = board.distance

      # refresh the checksum
      @boards[board] = @checksums[board] + @distances[board]
    else
      # the new state is reached already and the distance form the start is less
      # this is a dead-end, never a solution
    end
  end

  def shift
    evaluations = @boards.values

    min_checksum = evaluations[0]
    evaluations.each { |checksum| min_checksum = checksum if min_checksum > checksum }

    index_of_best_board = evaluations.index(min_checksum)
    board = @boards.keys[index_of_best_board]

    @boards.delete(board)
    @checksums.delete(board)

    board
  end
end

module Puzzle
  def self.solve
    print 'Enter n (n = k^2, k = 1,2,...): '
    n = gets.to_i

    print "\nEnter the rows:\n"
    initial_board = []
    Math.sqrt(n).to_i.times { initial_board << gets.split(' ').map(&:to_i) }

    Board.generate_final_state(n)
    p Board.solve_puzzle(Board.new(initial_board, 0))

    # Board.generate_final_state(9)
    # p Board.solve_puzzle(Board.new([[3,6,8],[1,0,2],[4,7,5]], 0))
  end
end

Puzzle::solve
