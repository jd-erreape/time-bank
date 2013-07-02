require 'test_helper'
require 'mocha/setup'

class FavorSearcherTest < ActiveSupport::TestCase
  test 'search empty with MatcherSearcher' do
    assert_equal [], FavorSearcher.search([], "", MatcherSearcher)
  end

  test 'search by title with MatcherSearcher' do
    favor_attributes = {:title => "Title"}
    favor = Favor.new(favor_attributes)
    assert_equal [favor], FavorSearcher.search([favor], favor_attributes[:title], MatcherSearcher)
  end

end

class Favor

  attr_accessor :title

  def initialize(attributes)
    self.title=attributes[:title]
  end

end



