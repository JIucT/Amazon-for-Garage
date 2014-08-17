class BooksCreator
  def self.populate
    for i in 0..50
      author_id = Author.create({firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, biography: Faker::Lorem.paragraph(Random::rand(10)+1)}).id
      category_id = Category.create({title: Faker::Company.name}).id
      b = Book.new({ title: Faker::Name.name, description: Faker::Lorem.paragraph(Random::rand(10)+1), 
          price: Faker::Commerce.price, in_stock: Random::rand(30), author_id: author_id,
          category_id: category_id})
      b.save!
    end
  end
end