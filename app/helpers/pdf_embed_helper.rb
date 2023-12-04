module PdfEmbedHelper
  # Calculate the character limit for each chunk of text
  def calculate_character_limit
    2000 * 4 # approx calculation
  end

  # Prepare the text for processing by replacing new lines with spaces and removing multiple spaces
  def prepare_text(text)
    text = replace_new_lines_with_spaces(text)
    text = remove_multiple_spaces(text)
    text
  end

  # Replace new lines with spaces
  def replace_new_lines_with_spaces(text)
    text.gsub(/\n/, ' ')
  end

  # Remove multiple spaces
  def remove_multiple_spaces(text)
    text.gsub(/\s+/, ' ')
  end

  # Break the text into chunks based on the character limit
  def break_into_chunks(text, character_limit)
    text.scan(/.{1,#{character_limit}}/)
  end

  # Validate if the file path is a valid PDF file
  def valid_pdf?(filepath)
    File.extname(filepath) == '.pdf'
  end
end