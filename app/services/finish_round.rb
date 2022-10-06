class FinishRound
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def complete
    if round.correct_answers_count == 5 && !round.completed?
      round.completed!
    end
    self
  end

  def give_points_for(user)
   if round.completed? && round.points_not_given?
      user.update(points: user.points += 10)
      round.update(points_given: true)
    end
    self
  end
end
