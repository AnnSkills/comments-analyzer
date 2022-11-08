class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.belongs_to :post
      t.string :tag_name
      t.integer :confidence
      t.timestamps
    end
  end
end
