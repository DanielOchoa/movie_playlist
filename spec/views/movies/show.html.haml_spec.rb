require 'spec_helper'

describe "movies/show" do
  before(:each) do
    @movie = assign(:movie, stub_model(Movie,
      :rotting_id => 1,
      :title => "Title",
      :synopsis => "MyText",
      :runtime => 2,
      :year => 3,
      :rating => 4,
      :mpaa_rating => "Mpaa Rating",
      :thumb => "Thumb",
      :original => "Original"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Mpaa Rating/)
    rendered.should match(/Thumb/)
    rendered.should match(/Original/)
  end
end
