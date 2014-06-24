
class Movie < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :title, presence: true
  validates :rating, presence: true,
                     inclusion: {in: ['G','PG','PG-13','R', 'NC-17'], allow_blank: true }
  validates :release_date, presence: { message: "looks bad"}

  before_validation :generate_twin_id, on: :create

  def self.all_ratings
   Movie.select(:rating).distinct.pluck(:rating)
   #@all_ratings = %W[G PG PG-13 NC-17 R]
  end

  def self.order_where (selected_ratings, order_params)
  Movie.where(rating: selected_ratings).order(order_params)    
  end

  def generate_twin_id
  self.twin_id = SecureRandom.uuid
  end
  
end
