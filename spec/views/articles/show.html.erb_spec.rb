require 'spec_helper'

describe "articles/show" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :name => "Name",
      :image => "MyText",
      :price => "",
      :delivertime => 1,
      :supplierid => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
