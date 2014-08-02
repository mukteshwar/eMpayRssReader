class CreateFeedurls < ActiveRecord::Migration
  def change
    create_table :feedurls do |t|
      t.string :feed_title
      t.string :feed_url

      t.timestamps
    end
  end
end
