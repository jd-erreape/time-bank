# Delete:
#
# - extend ActiveModel::Naming
# - include ActiveModel::Conversion
# - persisted? method
#
# When ActiveRecord is included
#
class Favor
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :title, :description, :time

  def initialize(*args)
    options = args.extract_options!
    @title = options[:title]
    @description = options[:description]
    @time = options[:time]
  end

  def persisted?
    false
  end
end