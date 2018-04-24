class Detail_scraper < BeeeerController
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
        info = get_meta(beer)
        row = save_to_db_meta(info)
				link = beer.at('a').get_attribute(:href)
        details = get_details(link)
        save_to_db(details, row.id)
			end

			# 次ページへのタグを取得
			next_link = current_page.at('#pagnNextLink')
			page_count += 1 		

			# next_linkがなかったらwhileを抜ける
			break unless next_link
			# 10ページ以上みたら抜ける
			break if page_count >= 20

			next_url = next_link.get_attribute(:href) 
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

	def self.save_to_db(details, beeeer_id)
		beer = ProductDetail.where(beeeer_id: beeeer_id).first_or_initialize
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

	def self.get_meta(html)
		info = {}
		info[:item_name] = html.css('h2.a-size-base.s-inline.s-access-title.a-text-normal').inner_text
		info[:image_url] = html.at('img.s-access-image.cfMarker').get_attribute(:src)
		info[:product_url] = html.at('a').get_attribute(:href)
		info[:price] = html.css('span.a-size-base.a-color-price.s-price.a-text-bold').inner_text
		info[:price].gsub!(/[\s￥,]/,"")
		/(\d+)本/.match(info[:item_name])
		price_i = info[:price].to_i

		if price_i == nil
			info[:price_per_can] = nil
		else
			# info[:price_per_can] = price_i.quo($1).round
		end
		return info
	end

	def self.save_to_db_meta(info)
		beer = Beeeer.where(item_name: info[:item_name], image_url: info[:image_url], price: info[:price]).first_or_initialize
		beer.image_url = info[:image_url] if info[:image_url]
		beer.product_url = info[:product_url] if info[:product_url]
		beer.price = info[:price] if info[:price]
		beer.price_per_can = info[:price_per_can] if info[:price_per_can]
		beer.save
    return beer
	end
end
