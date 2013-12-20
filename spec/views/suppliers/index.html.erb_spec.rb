require 'spec_helper'

describe "suppliers/index" do
  before(:each) do
    assign(:suppliers, [
      stub_model(Supplier,
        :name => "Name",
        :street => "Street",
        :zip => "Zip",
        :email => "Email",
        :phone => "Phone",
        :url => "Url"
      ),
      stub_model(Supplier,
        :name => "Name",
        :street => "Street",
        :zip => "Zip",
        :email => "Email",
        :phone => "Phone",
        :url => "Url"
      )
    ])
  end

  it "renders a list of suppliers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
