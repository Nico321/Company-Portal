require 'spec_helper'

describe "bugreports/show" do
  before(:each) do
    @bugreport = assign(:bugreport, stub_model(Bugreport,
      :subject => "Subject",
      :description => "MyText",
      :userid => 1,
      :employeeid => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
