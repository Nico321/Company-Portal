require 'spec_helper'

describe "businessprocesses/edit" do
  before(:each) do
    @businessprocess = assign(:businessprocess, stub_model(Businessprocess,
      :customerid => 1,
      :subject => "MyString",
      :request => "MyText",
      :employeeid => 1,
      :urgency => 1,
      :stateid => 1,
      :discount => "",
      :offer => "MyText",
      :installationprice => ""
    ))
  end

  it "renders the edit businessprocess form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", businessprocess_path(@businessprocess), "post" do
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
