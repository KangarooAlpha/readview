class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.references :postable, polymorphic: true, null: false
      t.references :contentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
