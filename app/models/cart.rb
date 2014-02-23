class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	# Raises the quantity of an line item by one
	# if its currently in the cart. If it isn't a new
	# line_item is created
	def add_article(article_id)
		current_item = line_items.find_by(article_id: article_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(article_id: article_id)
		end
		return current_item
	end

	# Decrements the quantity of an line item by one
	# if more than two of them are currently in the cart.
	# Otherwise the line item is destroyed
	def remove_article(article_id)
		current_item = line_items.find_by(article_id: article_id)
		if current_item
		   if current_item.quantity >1
			 current_item.quantity -=1
			 current_item.save
			else 
				current_item.destroy
			end
		end

		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price}
	end
end
