class Invoice < ActiveRecord::Base
	belongs_to :customer, :class_name => "User"
	belongs_to :agent, :class_name => "User"

	has_one :installation

	has_many :notes
	has_many :positions

	validates :subject, :customer, :installation, presence: true

	def paypal_url(return_url, notify_url)
	  values = {
	    :business => 'seller@cp.com',
	    :cmd => '_cart',
	    :upload => 1,
	    :return => return_url,
	    :invoice => id,
	    :notify_url => notify_url
	  }
	  positions.each_with_index do |item, index|
	    values.merge!({
	      "amount_#{index+1}" => item.article.price,
	      "item_name_#{index+1}" => item.article.name,
	      "item_number_#{index+1}" => item.article.id,
	      "quantity_#{index+1}" => item.quantity
	    })
	  end
	  if (installationprice != nil)
	  	values.merge!({
	      "amount_#{positions.count+1}" => installationprice,
	      "item_name_#{positions.count+1}" => "Installation",
	      "quantity_#{positions.count+1}" => 1
	    })
	  end
	  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
	end
	
	def self.search(search)
	  if search
	    where('subject LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end
end
