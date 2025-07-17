class CreatePostLikings < ActiveRecord::Migration[8.0]
  def change
    create_table :post_likings do |t|
      t.integer :reaction, default: 0

      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_likings, [ :user_id, :post_id ], unique: true
  end
end
