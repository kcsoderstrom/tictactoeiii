class AI
  def self.get_next_move(board)
    new_node = CrystalBallNode.new(board)

    # First try to find a definitely-winning move
    new_node.all_possible_next_nodes.each do |node|
      if node.winning_node?
        return node.last_move_position
      end
    end

    # Next try to find a move that doesn't ensure you lose
    new_node.all_possible_next_nodes.each do |node|
      unless node.losing_node?
        return node.last_move_position
      end
    end

    # If that doesn't work, play anywhere there's room
    board.first_empty_position
  end
end