class CreateImageContents < ActiveRecord::Migration[8.0]
  def change
    create_table :image_contents do |t|
      t.timestamps
    end
  end
end
