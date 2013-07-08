class FavorSearcher

  @@valid_searchable_attributes = [:title, :description]

  def self.valid_searchable_attributes
    @@valid_searchable_attributes
  end

  def self.search(query, searcher)
    searcher.find(valid_searchable_attributes, query)
  end

end