require 'spec_helper'

describe "suppliers/new" do
  before(:each) do
    assign(:supplier, stub_model(Supplier,
      :name => "MyString",
      :street => "MyString",
      :zip => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new supplier form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", suppliers_path, "post" do
      assert_select "input#supplier_name[name=?]", "supplier[name]"
      assert_select "input#supplier_street[name=?]", "supplier[street]"
      assert_select "input#supplier_zip[name=?]", "supplier[zip]"
      assert_select "input#supplier_email[name=?]", "supplier[email]"
      assert_select "input#supplier_phone[name=?]", "supplier[phone]"
      assert_select "input#supplier_url[name=?]", "supplier[url]"
    end
  end
end
