class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
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

  # POST /questions/ask
  def ask
    # Find the question in the database or create a new one
    question = Question.find_or_initialize_by(question: params[:question])

    # If the question is new and valid, generate an embedding for it
    if question.new_record? && question.valid?
      question.embedding = helpers.generate_embedding(question)
      question.save
    end

    # If the question has an embedding, find the nearest item embeddings
    if question.embedding
      nearest_item = find_nearest_items(question.embedding)

      # Send the nearest item embeddings to OpenAI
      response = send_to_openai(question.question, nearest_item.text)

      # Render the response from OpenAI
      render json: response.dig('choices', 0, 'message'), status: :ok
    else
      # Render an error message if the question does not have an embedding
      render json: { error: 'Could not generate an answer for the question' }, status: :unprocessable_entity
    end
  end

  private

  # This method is used to whitelist the allowed parameters
  def question_params
    params.require(:question).permit(:question)
  end

  # This method is used to find the nearest item embeddings to a question embedding
  def find_nearest_items(embedding)
    Item.nearest_neighbors(:embedding, embedding, distance: "euclidean").first
  end

  # This method is used to send a question and nearest item embeddings to OpenAI
  def send_to_openai(question, context)
    openai_client = OpenAI::Client.new
    response = openai_client.chat(parameters: {
      model: 'gpt-3.5-turbo',
      messages: [{
        role: 'user', 
        content: "<<~CONTENT)
        Answer the question based on the context below, and
        if the question can't be answered based on the context,
        say \"I don't know\".

        Context:
        #{context}

        ---

        Question: #{question}
        CONTENT"
      }],
      temperature: 0.5
    })
  end
end