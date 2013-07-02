require 'test_helper'
require 'mocha/setup'

class MatcherSearcherTest < ActiveSupport::TestCase
  test 'match empty query' do
    object = stub(:title => "Title", :description => "Description")
    matcher_searcher = MatcherSearcher.new(:bag => [object])
    assert_equal false, matcher_searcher.match(object, FavorSearcher.valid_searchable_attributes, "")
  end

  test 'match with title' do
    object = stub(:title => "Title", :description => "Description")
    matcher_searcher = MatcherSearcher.new(:bag => [object])
    assert_equal true, matcher_searcher.match(object, FavorSearcher.valid_searchable_attributes, "Ti")
  end

  test 'match with description' do
    object = stub(:title => "Title", :description => "Description")
    matcher_searcher = MatcherSearcher.new(:bag => [object])
    assert_equal true, matcher_searcher.match(object, FavorSearcher.valid_searchable_attributes, "Desc")
  end

  test 'doesnt match' do
    object = stub(:title => "Title", :description => "Description")
    matcher_searcher = MatcherSearcher.new(:bag => [object])
    assert_equal false, matcher_searcher.match(object, FavorSearcher.valid_searchable_attributes, "Other")
  end

  test 'doesnt match without right fields' do
    object = stub(:title => "Title", :description => "Description")
    matcher_searcher = MatcherSearcher.new(:bag => [object])
    assert_equal false, matcher_searcher.match(object, FavorSearcher.valid_searchable_attributes, "Other")
  end

  test 'find' do
    object = stub(:title => "Title", :description => "Description")
    matcher_searcher = MatcherSearcher.new(:bag => [object])
    assert_equal [object], matcher_searcher.find(FavorSearcher.valid_searchable_attributes, "Ti")
  end


end




