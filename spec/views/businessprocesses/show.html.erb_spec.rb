require 'spec_helper'

describe "businessprocesses/show" do
  before(:each) do
    @businessprocess = assign(:businessprocess, stub_model(Businessprocess,
      :customerid => 1,
      :subject => "Subject",
      :request => "MyText",
      :employeeid => 2,
      :urgency => 3,
      :stateid => 4,
      :discount => "",
      :offer => "MyText",
      :installationprice => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Subject/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
