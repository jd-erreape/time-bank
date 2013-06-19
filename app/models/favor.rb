class Favor
  attr_accessor :title, :description, :time

  def initialize(*args)
    options = args.extract_options!
    @title = options[:title]
    @description = options[:description]
    @time = options[:time]
  end
end