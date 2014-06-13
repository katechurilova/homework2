require 'spec_helper'

describe Movie do

  context ".all_ratings" do

    it 'No movies - no ratings' do
      expect(Movie.all_ratings).to eq([])
    end

    it 'One movie - one rating' do
      Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
      expect(Movie.all_ratings).to eq(['R'])
    end

    it 'Another movie - another rating' do
      Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
      expect(Movie.all_ratings).to eq(['PG'])
    end

    it 'Two movies - two ratings' do
      Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
      Movie.create(title: 'aaa', rating: 'R', release_date: Date.today)
      expect(Movie.all_ratings).to eq(['PG', 'R'])
    end

    it 'No duplicates' do
      Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
      Movie.create(title: 'aaa', rating: 'PG', release_date: Date.today)
      expect(Movie.all_ratings).to eq(['PG'])
    end
#######################
    it 'Bad rating - no movies' do
      Movie.create(title: 'aaa', rating: 'KK', release_date: Date.today)
      expect(Movie.all_ratings).to eq([])
    end

  end

    context ".order_where" do

     let!(:test_movie1) {Movie.create(title: 'Anna', rating: 'G', release_date: DateTime.now-1)} 
     let!(:test_movie2) {Movie.create(title: 'Barbara', rating: 'PG', release_date: DateTime.now)}

      it 'One selected rating' do
      expect(Movie.order_where(['G'],'')).to eq([test_movie1])
      end

      it 'Two selected raitings' do
      expect(Movie.order_where(['G','PG'],'')).to eq([test_movie1,test_movie2])
      end

      it 'All raitings selected' do
      expect(Movie.order_where(['G','PG','PG-13','R', 'NC-17'],'')).to eq([test_movie1,test_movie2])
      end
     
      it 'No movies with selected rating' do
      expect(Movie.order_where(['PG-13'],'')).to eq([])
      end
      
      it 'Order by title asc' do
      expect(Movie.order_where(['G','PG'],'title asc')).to eq([test_movie1,test_movie2])
      end

      it 'Order by title desc' do
      expect(Movie.order_where(['G','PG'],'title desc')).to eq([test_movie2,test_movie1])
      end

      it 'Order by release_date asc' do
      expect(Movie.order_where(['G','PG'],'release_date asc')).to eq([test_movie1,test_movie2])
      end

      it 'Order by release_date desc' do
      expect(Movie.order_where(['G','PG'],'release_date desc')).to eq([test_movie2,test_movie1])
      end

    end

end