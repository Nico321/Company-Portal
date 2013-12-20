require 'spec_helper'

describe "notes/show" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :subject => "Subject",
      :body => "MyText",
      :stateid => 1,
      :imageurl => "MyText",
      :businessprocessid => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
  end
end
