class Board
  attr_reader :rows

  def self.parse(board_str)
    raise Exception.new('Wrong size') if board_str.length != 9
    [
      board_str[0..2].split(//),
      board_str[3..5].split(//),
      board_str[6..8].split(//)
    ]
  end

  # TODO: Make usable to check for other player's turn too
  # It will involve a little more work to see if the board is full
  def is_os_turn
    counts = @rows.flatten.each_with_object(Hash.new(0)) do |char, hash|
      hash[char] += 1
    end

    # TODO: Add a config that makes it easy to change who is playing first
    return true if counts['o'] == counts['x']
    return true if counts['o'] == counts['x'] - 1 and !tied?
    false
  end

  def initialize(board_str, validate = false)
    if board_str.kind_of?(Array)
      @rows = board_str
    else
      @rows = Board.parse(board_str)
    end

    if validate
      raise Exception.new('Invalid turn') unless is_os_turn
    end
  end

  def [](x, y)
    @rows[x][y]
  end

  def []=(x, y, scratch)
    @rows[x][y] = scratch
  end

  def place_o!
    next_move_position = AI.get_next_move(self)
    self[next_move_position[0], next_move_position[1]] = 'o'
  end

  def to_s
    @rows.flatten.join()
  end

  def diagonals
    top_left_to_bottom_right = [[0, 0], [1, 1], [2, 2]]
    top_right_to_bottom_left = [[0, 2], [1, 1], [2, 0]]

    [top_left_to_bottom_right, top_right_to_bottom_left].map do |diagonal_coordinates|
      diagonal_coordinates.map { |x, y| @rows[x][y] }
    end
  end

  def columns
    cols = [[], [], []]
    @rows.each do |row|
      row.each_with_index do |team, idx|
        cols[idx] << team
      end
    end

    cols
  end

  def winner
    [columns, diagonals, rows].each do |arrangement|
      arrangement.each do |cut|
        if is_all_one_character(cut)
          return cut[0] unless cut[0] == ' '
        end
      end
    end

    nil
  end

  def is_all_one_character(arr)
    return true if arr.uniq == arr[0..0]
  end

  def empty?(x, y)
    self[x, y] == ' '
  end

  def first_empty_position
    3.times do |y|
      3.times do |x|
        return [x, y] if self.empty?(x, y)
      end
    end
  end

  def over?
    won? || tied?
  end

  def tied?
    return false if won?
    @rows.all? { |row| row.none? { |el| el == ' ' }}
  end

  def won?
    !winner.nil?
  end

  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

end