require 'spec_helper'

describe Link do
	
	context "Demonstration of how DataMapper works" do

		it 'should be created and then retrieved from the db' do
			expect(Link.count).to eq(2)
			Link.create(:title => "Makers Academy", :url => "http://www.makersacademy.com/")
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq("http://www.makersacademy.com/")
		expect(link.title).to eq("Makers Academy")

		link.destroy

		expect(Link.count).to eq(2)


		end

	end	


end