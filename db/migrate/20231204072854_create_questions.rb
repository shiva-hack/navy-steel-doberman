class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end
