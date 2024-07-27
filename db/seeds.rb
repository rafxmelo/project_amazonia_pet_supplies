require 'faker'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'net/http'

ActiveRecord::Base.transaction do
  # Provinces
  provinces = [
    { name: 'Ontario', gst: 0.05, pst: 0.08, hst: 0.13 },
    { name: 'Quebec', gst: 0.05, pst: 0.0975, hst: 0 }
    # Add more provinces as needed
  ]
  provinces.each do |province|
    Province.find_or_create_by!(province)
  end

  # Admin Users
  unless AdminUser.exists?(email: 'admin@example.com')
    AdminUser.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  # Users
  unless User.exists?(email: 'admin@example.com')
    User.create!(
      username: 'jao',
      email: 'jao@example.com',
      password: 'password',
      address: '123 Main St',
      province: Province.first
    )
  end

  # Categories
  categories = ['Food', 'Toys', 'Accessories', 'Housing']
  categories.each do |category|
    Category.find_or_create_by!(name: category)
  end

  # Array of image paths
  image_paths = Dir[Rails.root.join('app', 'assets', 'images', 'seeds', '*.jpg')]

  # 1.6: Seeding 100 products across 4 categories using Faker
  100.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price,
      stock_quantity: rand(1..100),
      on_sale: false
    )

    # Randomly assign an image to the product
    image_path = image_paths.sample
    if File.exist?(image_path)
      product.image.attach(io: File.open(image_path), filename: File.basename(image_path))
    else
      puts "Image file not found: #{image_path}"
    end

    ProductCategory.create!(product: product, category: Category.order('RANDOM()').first)
  end

  # 1.7: Scraping products and categories from eBay
  def scrape_products
    url = 'https://www.ebay.com/sch/i.html?_nkw=aluminum'
    html = URI.open(url, 'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3')
    doc = Nokogiri::HTML(html)

    doc.css('.s-item').each do |product_node|
      name = product_node.css('.s-item__title').text.strip
      price = product_node.css('.s-item__price').text.strip.gsub(/[^\d.]/, '').to_f
      category_name = "Aluminum Products" # Since the category is implied by the search

      category = Category.find_or_create_by!(name: category_name)
      product = Product.create!(
        name: name,
        description: "No description available.",
        price: price,
        stock_quantity: rand(1..100)
      )

      ProductCategory.create!(product: product, category: category)
    end
  end

  scrape_products

  # 1.8: Fetching products and categories from an API
  def fetch_products_from_api
    url = URI.parse('https://dummyjson.com/products')
    response = Net::HTTP.get_response(url)
    products = JSON.parse(response.body)['products']

    products.each do |product_data|
      category = Category.find_or_create_by!(name: product_data['category'])
      product = Product.create!(
        name: product_data['title'],
        description: product_data['description'],
        price: product_data['price'].to_f,
        stock_quantity: product_data['stock'].to_i
      )

      ProductCategory.create!(product: product, category: category)
    end
  end

  fetch_products_from_api

  # Pages
  Page.find_or_create_by!(title: 'Contact') do |page|
    page.content = '<p>Contact us at contact@example.com.</p>'
  end

  Page.find_or_create_by!(title: 'About') do |page|
    page.content = '<p>This is the About page content.</p>'
  end
end
