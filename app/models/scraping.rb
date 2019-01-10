# class Scraping
  # def self.movie_urls
    # 映画の個別ページのURLを取得
    # get_product(link)を呼び出す
    # puts 'get movies link URL'
  # end

  # def self.get_product(link)
    # 「作品名」と「作品画像のURL」をスクレイピング
    # スクレイピングした「作品名」と「作品画像のURL」をProductsテーブルに保存
    # puts 'get movie information'
  # end
# end
class Scraping
  def self.movie_urls
  #   links = []
  #   agent = Mechanize.new
  #   current_page = agent.get("http://review-movie.herokuapp.com/")
  #   elements = current_page.search('.entry-title a')
  #   elements.each do |ele|
  #     links << ele.get_attribute('href')
  #   end

  #   links.each do |link|
  #     get_product('http://review-movie.herokuapp.com/' + link)
  #   end
  # end

    links = []
    agent = Mechanize.new
    next_url = ""

    while true
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search('.entry-title a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')

    end
    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')

    director = page.at('.director span').inner_text if page.at('.director span')
    detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
    open_date = page.at('.date span').inner_text if page.at('.date span')

    product = Product.where(title: title).first_or_initialize
    product.image_url = image_url
    product.director = director
    product.detail = detail
    product.open_date = open_date

    # product = Product.new(title: title, image_url: image_url)
    # product = Product.where(title: title, image_url: image_url).first_or_initialize
    product.save
  end
end
