class FavorSearcher

  @@valid_searchable_attributes = [:title, :description]

  def self.valid_searchable_attributes
    @@valid_searchable_attributes
  end

  def self.search(objects, query, searcher_class)
    result = []
    objects.each do |object|
      result << object if searcher_class.match(object, valid_searchable_attributes, query)
    end
    result
  end

end