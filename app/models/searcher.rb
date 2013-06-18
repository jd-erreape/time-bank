class Searcher

  def self.search(objects, query)

    result = []
    objects.each do |object|
      result << object if object.title.match(/.*#{query}.*/)
    end
    result
  end

end