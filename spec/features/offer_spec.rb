require 'spec_helper'

describe "Offer" do

	let!(:superadmin){FactoryGirl.create(:superadmin)}
	let!(:offer){FactoryGirl.create(:offer)}
	let!(:request){FactoryGirl.create(:request)}
	let!(:article){FactoryGirl.create(:article)}
	let!(:pos){FactoryGirl.create(:position)}	
	let!(:order){FactoryGirl.create(:order)}

	before :each do
		login(superadmin)
	end

	it 'convert a request to an offer' do
		request.agent = superadmin
		request.save
		visit request_path(request)

		expect{click_link "Create Offer"}.to change{Offer.all.count}.by(1)
	end

	it 'add a note to an Offer' do
		visit offer_path(offer)
		addNote
		page.should have_content "myTestNote"
	end

	it 'can assume an offer' do
		visit unassumed_offers_path

		expect{click_link "Assume", match: :first}.to change{Offer.where("agent_id IS NOT NULL").count}.by(1)
	end

	it 'can release an offer' do
		offer.agent = superadmin
		offer.save
		visit assumed_offers_path

		expect{click_link "Release"}.to change{Offer.where("agent_id IS NOT NULL").count}.by(-1)
	end

	it 'can add a position to an Offer' do
		offer.agent = superadmin
		offer.save
		visit edit_offer_path(offer)
		click_link "Add a position"
		expect{click_button "Add position"}.to change{Position.all.count}.by(1)
	end

	it 'can publish an offer' do
		offer.agent = superadmin
		pos.offer = offer
		pos.order = order
		pos.save
		offer.save
		visit edit_offer_path(offer)
		page.should have_content "Publish"
		expect{click_link "Publish"}.to change{Offer.where('assignment_id IS NULL AND publication IS NOT NULL').count}.by(1)
	end

	it 'can decline and offer' do
		offer.customer = superadmin
		offer.publication = DateTime.now
		offer.save

		visit offer_path(offer)
		click_link "Decline"
		page.should_not have_content "Decline"
	end
end