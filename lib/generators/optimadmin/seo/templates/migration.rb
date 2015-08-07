class CreateSeoEntries < ActiveRecord::Migration
  def change
    create_table :seo_entries do |t|
      t.string :nominal_url
      t.string :title
      t.text :meta_description
      t.boolean :in_sitemap, :default => true

      t.timestamps
    end
  end
end
