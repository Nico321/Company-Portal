require 'spec_helper'

describe "businessprocesses/index" do
  before(:each) do
    assign(:businessprocesses, [
      stub_model(Businessprocess,
        :customerid => 1,
        :subject => "Subject",
        :request => "MyText",
        :employeeid => 2,
        :urgency => 3,
        :stateid => 4,
        :discount => "",
        :offer => "MyText",
        :installationprice => ""
      ),
      stub_model(Businessprocess,
        :customerid => 1,
        :subject => "Subject",
        :request => "MyText",
        :employeeid => 2,
        :urgency => 3,
        :stateid => 4,
        :discount => "",
        :offer => "MyText",
        :installationprice => ""
      )
    ])
  end

  it "renders a list of businessprocesses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
