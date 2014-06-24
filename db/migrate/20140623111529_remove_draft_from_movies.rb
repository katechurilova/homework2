class RemoveDraftFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :draft, :boolean
  end
end
