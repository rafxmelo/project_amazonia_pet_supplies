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
      username: 'admin',
      email: 'admin@example.com',
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

  # Products
  10.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price,
      stock_quantity: rand(1..100)
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
end
