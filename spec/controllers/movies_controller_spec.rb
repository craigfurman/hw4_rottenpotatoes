require 'spec_helper'

describe MoviesController do
  it "should query the movies model for a list of similar movies" do
    id = "42"
    mock_movie = Movie.new({:director => 'Jurgen Haabermaaster'})
    Movie.should_receive(:find).with(id).and_return(mock_movie)
    Movie.should_receive(:find_similar_movies).with(mock_movie)
    get :similar, { :id => id }
  end
  
  it "should make list of movies available to the view" do
    id = "42"
    similar_movies = ["a_mock"]
    Movie.stub(:find).and_return(Movie.new({:director => 'Jurgen Haabermaaster'}))
    Movie.stub(:find_similar_movies).and_return(similar_movies)
    get :similar, { :id => id }
    assigns(:similar_movies).should == similar_movies
  end
  
  it "should redirect to home page if no director info is listed for movie" do
    id = "42"
    movie_with_no_director = Movie.new({:title => "movie"})
    Movie.stub(:find).with(id).and_return(movie_with_no_director)
    get :similar, {:id => id}
    response.should redirect_to(movies_path)
    flash[:no_director].should == "movie"
  end
  
  it "should redirect to home page if director is empty string" do
    id = "42"
    movie_with_no_director = Movie.new({:title => "movie", :director => ''})
    Movie.stub(:find).with(id).and_return(movie_with_no_director)
    get :similar, {:id => id}
    response.should redirect_to(movies_path)
    flash[:no_director].should == "movie"
  end
end
