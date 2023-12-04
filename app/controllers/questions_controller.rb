class QuestionsController < ApplicationController
  # GET /questions
  # This action is used to fetch all questions or search for specific questions
  def index
    # Use the helper method to search for questions based on the search parameter
    questions = helpers.search_questions(params[:search])

    # If there are no questions, render an empty array, otherwise render the questions
    render json: questions.empty? ? [] : questions, status: :ok
  end

  # POST /questions
  # This action is used to create a new question
  def create
    # Create a new question with the given parameters
    question = Question.new(question_params)

    # If the question is valid, generate an embedding for it using the helper method
    if question.valid?
      question.embedding = helpers.generate_embedding(question)
    end

    # If the question is saved successfully, render the question, otherwise render the errors
    if question.save
      render json: question, status: :created
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/:id
  # This action is used to delete a question
  def destroy
    # Find the question by id
    question = Question.find(params[:id])

    # If the question is deleted successfully, render the question, otherwise render the errors
    if question.destroy
      render json: question, status: :ok
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end
end