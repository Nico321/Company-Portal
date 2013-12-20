require 'spec_helper'

describe "bugreports/edit" do
  before(:each) do
    @bugreport = assign(:bugreport, stub_model(Bugreport,
      :subject => "MyString",
      :description => "MyText",
      :userid => 1,
      :employeeid => 1
    ))
  end

  it "renders the edit bugreport form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bugreport_path(@bugreport), "post" do
      assert_select "input#bugreport_subject[name=?]", "bugreport[subject]"
      assert_select "textarea#bugreport_description[name=?]", "bugreport[description]"
      assert_select "input#bugreport_userid[name=?]", "bugreport[userid]"
      assert_select "input#bugreport_employeeid[name=?]", "bugreport[employeeid]"
    end
  end
end
