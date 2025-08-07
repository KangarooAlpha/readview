class CreateTextContents < ActiveRecord::Migration[8.0]
  def change
    create_table :text_contents do |t|
      t.text :body

      t.timestamps
    end
  end
end
