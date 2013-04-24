class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :rotting_id
      t.string :title
      t.text :synopsis
      t.integer :runtime
      t.integer :year
      t.integer :rating
      t.string :mpaa_rating
      t.string :thumb
      t.string :original

      t.timestamps
    end
  end
end
