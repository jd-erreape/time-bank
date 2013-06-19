class Matcher

  def self.match(object, fields, query)
    fields.each do |field|
      return true if object.try(field) && object.try(field).match(/.*#{query}.*/)
    end unless query.blank?
    false
  end

end