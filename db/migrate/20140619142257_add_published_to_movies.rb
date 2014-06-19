class AddPublishedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :published, :boolean, default: true
  end
end
