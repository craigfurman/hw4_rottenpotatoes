Given /the following movies exist/ do |table|
  table.hashes.each { |movie_hash| Movie.create movie_hash }
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  page.should have_content @movie
  page.find("#director").should have_content @director
end
