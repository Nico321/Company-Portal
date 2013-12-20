require 'spec_helper'

describe "bugreports/index" do
  before(:each) do
    assign(:bugreports, [
      stub_model(Bugreport,
        :subject => "Subject",
        :description => "MyText",
        :userid => 1,
        :employeeid => 2
      ),
      stub_model(Bugreport,
        :subject => "Subject",
        :description => "MyText",
        :userid => 1,
        :employeeid => 2
      )
    ])
  end

  it "renders a list of bugreports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
