class Board
  attr_reader :rows

  def self.parse(board_str)
    # TODO: handle errors
    [
      board_str[0..2].split(//),
      board_str[3..5].split(//),
      board_str[6..8].split(//)
    ]
  end

  def initialize(board_str)
    @rows = Board.parse(board_str)
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
        if self[x, y] == ' '
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

end