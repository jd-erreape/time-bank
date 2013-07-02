require 'test_helper'
require 'mocha/setup'

class FavorSearcherTest < ActiveSupport::TestCase
  test 'search empty with MatcherSearcher' do
    favor_attributes = {:title => "Title"}
    favor = Favor.new(favor_attributes)
    assert_equal [], FavorSearcher.search("", MatcherSearcher.new(:bag => [favor]))
  end

  test 'search by title with MatcherSearcher' do
    favor_attributes = {:title => "Title"}
    favor = Favor.new(favor_attributes)
    assert_equal [favor], FavorSearcher.search(favor_attributes[:title], MatcherSearcher.new(:bag => [favor]))
  end

end



