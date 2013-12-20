require 'spec_helper'

describe "notes/index" do
  before(:each) do
    assign(:notes, [
      stub_model(Note,
        :subject => "Subject",
        :body => "MyText",
        :stateid => 1,
        :imageurl => "MyText",
        :businessprocessid => 2
      ),
      stub_model(Note,
        :subject => "Subject",
        :body => "MyText",
        :stateid => 1,
        :imageurl => "MyText",
        :businessprocessid => 2
      )
    ])
  end

  it "renders a list of notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
