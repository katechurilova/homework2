class AddDraftAndTwinIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :twin_id, :string
    add_column :movies, :draft, :boolean, default: true
  end
end
