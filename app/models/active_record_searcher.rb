class ActiveRecordSearcher

  attr_accessor :bag

  def initialize(attributes)
    self.bag=attributes[:bag]
  end

  def find(fields, query)
    self.bag.where(self.class.build_conditions(fields, query))
  end

  def self.build_conditions(fields, query)
    conditions = []
    fields.each do |field|
      conditions << "#{field.to_s} LIKE '%#{query}%'"
    end
    conditions.join(" OR ")
  end

end