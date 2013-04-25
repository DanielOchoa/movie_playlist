class AddIndexToMovies < ActiveRecord::Migration
  def change
    add_index :movies, :rotting_id
  end
end
