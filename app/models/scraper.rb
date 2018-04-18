class Scraper
	ROOT_URL = 'https://www.amazon.co.jp'
	SEARCH_URL = 'https://www.amazon.co.jp/b?node=71598051'

	def self.get_beer
		agent = Mechanize.new
		page = agent.get(SEARCH_URL) # スタートURL
		next_url = "/b?node=71598051" # 検索開始地点のパスを仕込んでおく
		page_count = 0

		while true do
			current_page = agent.get(ROOT_URL + next_url)  
			beers = current_page.search('div.s-item-container')
			beers.each do |beer|
				info = get_details(beer)
				save_to_db(info)				
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
	end

	def self.get_details(html)
		info = {}
		info[:item_name] = html.css('h2.a-size-base.s-inline.s-access-title.a-text-normal').inner_text
		info[:image_url] = html.at('img.s-access-image.cfMarker').get_attribute(:src)
		# info[:product_url] = ROOT_URL + html.at('a.aok-block.aok-nowrap.aok-hide-text.acs_product-image').get_attribute(:href)
		info[:price] = html.css('span.a-size-base.a-color-price.s-price.a-text-bold').inner_text
		info[:price].gsub!(/[\s￥,]/,"")
		/(\d+)本/.match(info[:item_name])
		info[:price_per_can] = info[:price].quo($1).round
		return info
	end

	def self.save_to_db(info)
		beer = Beeeer.where(item_name: info[:item_name], image_url: info[:image_url], price: info[:price]).first_or_initialize
		beer.image_url = info[:image_url] if info[:image_url]
		# beer.product_url = info[:product_url] if info[:product_url]
		beer.price = info[:price] if info[:price]
		beer.price_per_can = info[:price_per_can] if info[:price_per_can]
		beer.save
	end
end
