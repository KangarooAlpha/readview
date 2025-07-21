class CreateCommentLikings < ActiveRecord::Migration[8.0]
  def change
    create_table :comment_likings do |t|
      t.integer :reaction, default: 0

      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end

    add_index :comment_likings, [ :user_id, :comment_id ], unique: true
  end
end
