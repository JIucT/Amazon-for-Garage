class CategoriesEditor
  @titles = ['Mobile development', 'Photography', 'Web design', 'Web development']
  def self.correct
      Book.all.each do |book|
        book.category_id = nil
        book.save!
      end
      Category.all.destroy_all
      @titles.each do |tt|
        Category.create!(title: tt)
      end
      Book.all.each do |book|
        book.category_id = Category.offset(Random::rand(4)).first.id
        book.save!
      end
  end
end
