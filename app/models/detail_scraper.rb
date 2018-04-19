class Detail_scraper
	BASE_URL = 'https://www.amazon.co.jp'
	SEARCH_URL = 'https://www.amazon.co.jp/b?node=71598051'

	def self.get_beer_detail
		agent = Mechanize.new
		page = agent.get(SEARCH_URL) # スタートURL
		links = []
		next_url = ""
		page_count = 0

		while true do
			current_page = agent.get(SEARCH_URL)  
			beers = current_page.search('div.s-item-container')
			beers.each do |beer|
				links << beer.at('a').get_attribute(:href)
			end

			# 次ページへのタグを取得
			next_link = current_page.at('#pagnNextLink')
			page_count += 1 		

			# next_linkがなかったらwhileを抜ける
			break unless next_link
			# 10ページ以上みたら抜ける
			break if page_count >= 10

			next_url = next_link.get_attribute(:href) 
		end

		binding.pry
		links.each do |link|
			details = get_details(link)
#			save_to_db(details)
		end
	end

	def self.get_details(link)
		agent = Mechanize.new
		page = agent.get(link)

		details = {}
		labels = page.search('td.label')
		labels.each do |l|
			case l.inner_text
			when "ブランド"
				details[:brand] = l.at('td.value').inner_text 
				details[:brand2] = l.next.inner_text # 簡潔な書き方 
				puts details[:brand]
				puts details[:brand2]
#				details[:weight] =
#				details[:package_dim] = 
#				details[:origin] = 
#				# details[:quantity] = 
#				details[:manufacturer_name] = 
#				details[:package_type] = 
			else
				
			end
		end

		return details
	end

	def self.save_to_db(details)
		beer = Product_details.where(item_name: details[:item_name], image_url: details[:image_url], price: details[:price]).first_or_initialize
		beer.image_url = details[:image_url] if details[:image_url]
		beer.product_url = details[:product_url] if details[:product_url]
		beer.price = details[:price] if details[:price]
		beer.price_per_can = details[:price_per_can] if details[:price_per_can]
		beer.save
	end
end
