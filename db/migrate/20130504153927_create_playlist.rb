class CreatePlaylist < ActiveRecord::Migration
  def up
    create_table :playlists do |t|
      t.integer :user_id

      t.timestamps
    end

    add_index :playlists, :user_id
  end

  def down
  end
end
