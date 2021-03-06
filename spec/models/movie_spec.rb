require 'spec_helper'

describe Movie do
  it 'should find similar movies with same director' do
    movie = Movie.new
    director = "Craig Furman"
    similar_movie = 'The Governator'
    movie.director = director
    Movie.stub(:find_all_by_director).with(director).and_return([Movie.new({ :title => similar_movie })])
    
    similar_movies = Movie.find_similar_movies movie
    similar_movies.count.should == 1
    similar_movies[0].title.should == similar_movie
  end
end
