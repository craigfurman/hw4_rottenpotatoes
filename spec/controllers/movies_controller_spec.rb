require 'spec_helper'

describe MoviesController do
  it "should query the movies model for a list of similar movies" do
    id = "42"
    mock_movie = mock('Movie')
    Movie.should_receive(:find).with(id).and_return(mock_movie)
    Movie.should_receive(:find_similar_movies).with(mock_movie)
    get :similar, { :id => id }
  end
  
  it "should make list of movies available to the view" do
    id = "42"
    similar_movies = ["a_mock"]
    Movie.stub(:find)
    Movie.stub(:find_similar_movies).and_return(similar_movies)
    get :similar, { :id => id }
    assigns(:similar_movies).should == similar_movies
  end
end
