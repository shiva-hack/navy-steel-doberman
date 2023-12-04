class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :page
      t.text :text
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end
