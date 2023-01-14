class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end
