module QuestionsHelper
  # This method is used to search for questions based on a query.
  # If the query is present, it returns the questions where the question field contains the query.
  # If the query is not present, it returns all questions.
  def search_questions(query)
    if query.present?
      Question.where('question LIKE ?', "%#{query}%")
    else
      Question.all
    end
  end

  # This method is used to generate an embedding for a question using the OpenAI API.
  # It initializes the OpenAI client, sends a request to the API to generate an embedding,
  # and then extracts the embedding from the response.
  def generate_embedding(question)
    openai_client = OpenAI::Client.new
    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: question.question
      }
    )
    response.dig('data', 0, 'embedding')
  end
end