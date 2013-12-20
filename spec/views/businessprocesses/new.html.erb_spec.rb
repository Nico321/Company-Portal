require 'spec_helper'

describe "businessprocesses/new" do
  before(:each) do
    assign(:businessprocess, stub_model(Businessprocess,
      :customerid => 1,
      :subject => "MyString",
      :request => "MyText",
      :employeeid => 1,
      :urgency => 1,
      :stateid => 1,
      :discount => "",
      :offer => "MyText",
      :installationprice => ""
    ).as_new_record)
  end

  it "renders new businessprocess form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", businessprocesses_path, "post" do
      assert_select "input#businessprocess_customerid[name=?]", "businessprocess[customerid]"
      assert_select "input#businessprocess_subject[name=?]", "businessprocess[subject]"
      assert_select "textarea#businessprocess_request[name=?]", "businessprocess[request]"
      assert_select "input#businessprocess_employeeid[name=?]", "businessprocess[employeeid]"
      assert_select "input#businessprocess_urgency[name=?]", "businessprocess[urgency]"
      assert_select "input#businessprocess_stateid[name=?]", "businessprocess[stateid]"
      assert_select "input#businessprocess_discount[name=?]", "businessprocess[discount]"
      assert_select "textarea#businessprocess_offer[name=?]", "businessprocess[offer]"
      assert_select "input#businessprocess_installationprice[name=?]", "businessprocess[installationprice]"
    end
  end
end
