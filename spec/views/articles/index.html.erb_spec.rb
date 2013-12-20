require 'spec_helper'

describe "articles/index" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :name => "Name",
        :image => "MyText",
        :price => "",
        :delivertime => 1,
        :supplierid => 2
      ),
      stub_model(Article,
        :name => "Name",
        :image => "MyText",
        :price => "",
        :delivertime => 1,
        :supplierid => 2
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
