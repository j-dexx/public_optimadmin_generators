class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, unique: true
      t.string :suggested_url, unique: true
      t.string :image, null: true
      t.string :style, null: false
      t.string :layout, null: false
      t.boolean :display, null: true, default: true
      t.text :content, null: false

      t.timestamps null: false
    end
  end
end
