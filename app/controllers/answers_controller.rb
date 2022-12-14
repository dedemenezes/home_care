class AnswersController < ApplicationController
  def create
    set_round
    set_option
    set_question
    build_answer
    authorize @answer
    if @answer.save!
      @answer.correct! if @option.right?

      if @round.last_question? @question
        respond_to do |format|
          format.text do
            FinishRound.new(@round).complete.give_points_for(current_user)
            render(
              partial: "rounds/score",
              locals: { round: @round },
              formats: [:html]
            )
          end
          format.html { redirect_to score_round_path(@round) }
        end
        # redirect_to score_round_path(@round)
      else
        @next_question = @round.next_question
        # redirect_to round_path(@round, question: @next_question.id)
        respond_to do |format|
          format.text { render partial: "questions/show", locals: {question: @next_question, answer: Answer.new, round: @round}, formats: [:html] }
          format.html { redirect_to round_path(@round, question: @next_question.id) }
        end
      end
    else
      render 'rounds/show'
    end
  end

  private

  def set_question
    @question = @option.question
  end

  def build_answer
    @answer             = Answer.new
    @answer.round       = @round
    @answer.user_answer = @option
    @answer.question    = @question
  end

  def set_round
    @round = Round.find(params[:round_id])
  end

  def set_option
    @option = Option.find(params[:answer][:user_answer_id])
  end
end
