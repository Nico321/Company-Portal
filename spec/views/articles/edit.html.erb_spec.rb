require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :name => "MyString",
      :image => "MyText",
      :price => "",
      :delivertime => 1,
      :supplierid => 1
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_name[name=?]", "article[name]"
      assert_select "textarea#article_image[name=?]", "article[image]"
      assert_select "input#article_price[name=?]", "article[price]"
      assert_select "input#article_delivertime[name=?]", "article[delivertime]"
      assert_select "input#article_supplierid[name=?]", "article[supplierid]"
    end
  end
end
