class CreateFeedentries < ActiveRecord::Migration
  def change
    create_table :feedentries do |t|
      t.references :feedurl
      t.string :title
      t.string :link
      t.string :description
      t.string :guid
      t.datetime :publish_at

      t.timestamps
    end
  end
end
