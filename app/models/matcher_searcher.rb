class MatcherSearcher

  attr_accessor :bag

  def initialize(attributes)
    self.bag=attributes[:bag]
  end

  def find(fields, query)
    result = []
    self.bag.each do |item|
      result << item if self.match(item, fields, query)
    end
    result
  end

  def match(object, fields, query)
    fields.each do |field|
      return true if object.try(field) && object.try(field).match(/.*#{query}.*/)
    end unless query.blank?
    false
  end

end