class AddParentIdIndexToComment < ActiveRecord::Migration[8.0]
  def change
    add_index :comments, :parent_id
  end
end
