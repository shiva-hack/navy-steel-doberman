require 'pdf-reader'

class PdfEmbedController < ApplicationController
  # Main function to process a PDF file and create embeddings for each page
  def process(filepath)
    full_filepath = Rails.root.join(filepath)
    raise "Invalid File: The path #{full_filepath} is not a vaild pdf file or is not readable!" unless helpers.valid_pdf?(full_filepath)

    openai_client = OpenAI::Client.new
    character_limit = helpers.calculate_character_limit
    reader = PDF::Reader.new(full_filepath)

    reader.pages.each.with_index do |page, index|
      process_page(page, index, openai_client, character_limit)
    end
  end

  # Process each page of the PDF
  def process_page(page, index, openai_client, character_limit)
    text = helpers.prepare_text(page.text)
    chunks = helpers.break_into_chunks(text, character_limit)

    chunks.each do |chunk|
      process_chunk(chunk, index, openai_client)
    end
  end

  # Process each chunk of text
  def process_chunk(chunk, page_index, openai_client)
    return if item_exists?(chunk, page_index)

    embedding = get_embedding(chunk, openai_client)
    create_item(page_index, chunk, embedding)
  end

  # Check if an item with the same text already exists
  def item_exists?(chunk, page_index)
    if Item.find_by(text: chunk)
      puts "Embeddings for Page #{page_index + 1} already exists!"
      true
    else
      false
    end
  end

  # Get the embedding for a chunk of text using the OpenAI API
  def get_embedding(chunk, openai_client)
    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: chunk
      }
    )
    response.dig('data', 0, 'embedding')
  end

  # Create a new item with the page number, text, and embedding
  def create_item(page_index, chunk, embedding)
    Item.create!(page: page_index + 1, text: chunk, embedding: embedding)
    puts "Data for Page #{page_index + 1} created!"
  end
end
