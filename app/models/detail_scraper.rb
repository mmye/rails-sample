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

		links.each do |link|
			details = get_details(link)
			save_to_db(details)
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
				details[:brand] = l.next.inner_text
			when "アルコール度数"
				details[:alcohol_by_degree] = l.next.inner_text
			when "メーカー名"
				details[:manufacturer_name] = l.next.inner_text
			when "容器の種類"
				details[:package_type] = l.next.inner_text
			when "梱包サイズ"
				details[:package_dim] = l.next.inner_text
			when "商品重量"
				details[:weight] = l.next.inner_text
			when "原産国名"
				details[:origin] = l.next.inner_text
			when "商品説明"
				details[:description] = l.next.inner_text
			else
				
			end
		end

		return details
	end

	def self.save_to_db(details)
		beer = ProductDetail.where(item_name: details[:item_name], brand: details[:brand]).first_or_initialize
		beer.brand = details[:brand] if details[:brand]
		beer.alcohol_by_degree = details[:alcohol_by_degree] if details[:alcohol_by_degree]
		beer.manufacturer_name = details[:manufacturer_name] if details[:manufacturer_name]
		beer.package_type = details[:package_type] if details[:package_type]
		beer.package_dim = details[:package_dim] if details[:package_dim]
		beer.weight = details[:weight] if details[:weight]
		beer.origin = details[:origin] if details[:origin]
		beer.description = details[:description] if details[:description]
		beer.save
	end
end
