require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :subject => "MyString",
      :body => "MyText",
      :stateid => 1,
      :imageurl => "MyText",
      :businessprocessid => 1
    ))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", note_path(@note), "post" do
      assert_select "input#note_subject[name=?]", "note[subject]"
      assert_select "textarea#note_body[name=?]", "note[body]"
      assert_select "input#note_stateid[name=?]", "note[stateid]"
      assert_select "textarea#note_imageurl[name=?]", "note[imageurl]"
      assert_select "input#note_businessprocessid[name=?]", "note[businessprocessid]"
    end
  end
end
