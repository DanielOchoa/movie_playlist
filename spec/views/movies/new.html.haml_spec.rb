require 'spec_helper'

describe "movies/new" do
  before(:each) do
    assign(:movie, stub_model(Movie,
      :rotting_id => 1,
      :title => "MyString",
      :synopsis => "MyText",
      :runtime => 1,
      :year => 1,
      :rating => 1,
      :mpaa_rating => "MyString",
      :thumb => "MyString",
      :original => "MyString"
    ).as_new_record)
  end

  it "renders new movie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => movies_path, :method => "post" do
      assert_select "input#movie_rotting_id", :name => "movie[rotting_id]"
      assert_select "input#movie_title", :name => "movie[title]"
      assert_select "textarea#movie_synopsis", :name => "movie[synopsis]"
      assert_select "input#movie_runtime", :name => "movie[runtime]"
      assert_select "input#movie_year", :name => "movie[year]"
      assert_select "input#movie_rating", :name => "movie[rating]"
      assert_select "input#movie_mpaa_rating", :name => "movie[mpaa_rating]"
      assert_select "input#movie_thumb", :name => "movie[thumb]"
      assert_select "input#movie_original", :name => "movie[original]"
    end
  end
end
