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
  def is_second_players_turn
    counts = @rows.flatten.each_with_object(Hash.new(0)) do |char, hash|
      hash[char] += 1
    end

    # TODO: Add a config that makes it easy to change who is playing first
    return true if counts['o'] == counts['x']
  end

  def initialize(board_str)
    @rows = Board.parse(board_str)
    raise Exception.new('Invalid turn') unless is_second_players_turn
  end

  def [](x, y)
    @rows[x][y]
  end

  def []=(x, y, scratch)
    @rows[x][y] = scratch
  end

  def place_o!
    space_found = false
    (0..2).each do |y|
      (0..2).each do |x|
        puts self[x, y] == ' '
        if self.empty?(x, y)
          self[x, y] = 'o'
          space_found = true
          break
        end
      end
      break if space_found
    end
  end

  def to_s
    @rows.flatten.join()
  end

  def empty?(x, y)
    self[x, y] == ' '
  end

end