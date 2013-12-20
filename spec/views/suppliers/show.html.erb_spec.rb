require 'spec_helper'

describe "suppliers/show" do
  before(:each) do
    @supplier = assign(:supplier, stub_model(Supplier,
      :name => "Name",
      :street => "Street",
      :zip => "Zip",
      :email => "Email",
      :phone => "Phone",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Street/)
    rendered.should match(/Zip/)
    rendered.should match(/Email/)
    rendered.should match(/Phone/)
    rendered.should match(/Url/)
  end
end
