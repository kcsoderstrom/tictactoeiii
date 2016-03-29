class CrystalBallNode
  attr_reader :last_move_position

  def initialize(board, next_team = 'o', last_move_position = nil)
    @board = board
    @next_team = next_team
    @last_move_position = last_move_position
    @my_team = 'o'
  end

  def losing_node?
    return @my_team != @board.winner if @board.won?
    return false if @board.tied?

    if @my_team == @next_team
      return all_possible_next_nodes.all? do |node|
        node.losing_node?
      end
    else
      return all_possible_next_nodes.any? do |node|
        node.losing_node?
      end
    end
  end

  def winning_node?
    return @my_team == @board.winner if @board.over?
    if @my_team == @next_team
      return all_possible_next_nodes.any? do |node|
        node.winning_node?
      end
    else
      return all_possible_next_nodes.all? do |node|
        node.winning_node?
      end
    end
  end

  def all_possible_next_nodes
    empty_positions.map do |pos|
      test_board = @board.dup
      test_board[pos[0], pos[1]] = @next_team
      next_team = (@next_team == 'o' ? 'x' : 'o')

      CrystalBallNode.new(test_board, next_team, pos)
    end
  end

  def empty_positions
    empty_positions = []
    3.times do |i|
      3.times do |j|
        empty_positions << [i, j] if @board.empty?(i, j)
      end
    end
    empty_positions
  end

end