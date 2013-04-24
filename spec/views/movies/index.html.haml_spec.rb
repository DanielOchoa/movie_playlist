require 'spec_helper'

describe "movies/index" do
  before(:each) do
    assign(:movies, [
      stub_model(Movie,
        :rotting_id => 1,
        :title => "Title",
        :synopsis => "MyText",
        :runtime => 2,
        :year => 3,
        :rating => 4,
        :mpaa_rating => "Mpaa Rating",
        :thumb => "Thumb",
        :original => "Original"
      ),
      stub_model(Movie,
        :rotting_id => 1,
        :title => "Title",
        :synopsis => "MyText",
        :runtime => 2,
        :year => 3,
        :rating => 4,
        :mpaa_rating => "Mpaa Rating",
        :thumb => "Thumb",
        :original => "Original"
      )
    ])
  end

  it "renders a list of movies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Mpaa Rating".to_s, :count => 2
    assert_select "tr>td", :text => "Thumb".to_s, :count => 2
    assert_select "tr>td", :text => "Original".to_s, :count => 2
  end
end
