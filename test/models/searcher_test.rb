require 'test_helper'
require 'mocha/setup'

class SearcherTest < ActiveSupport::TestCase
  test 'search empty query' do
    assert_equal Searcher.search([], ""), []
  end

  test 'search by title' do
    favor_attributes = {:title => "Title"}
    favor = Favor.new(favor_attributes)
    assert_equal [favor], Searcher.search([favor], favor_attributes[:title])
  end

end

class Favor

  attr_accessor :title

  def initialize(attributes)
    self.title=attributes[:title]
  end

end



