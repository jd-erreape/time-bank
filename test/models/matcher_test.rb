require 'test_helper'
require 'mocha/setup'

class MatcherSearcherTest < ActiveSupport::TestCase
  test 'match empty query' do
    object = stub(:title => "Title", :description => "Description")
    assert_equal false, MatcherSearcher.match(object, FavorSearcher.valid_searchable_attributes, "")
  end

  test 'match with title' do
    object = stub(:title => "Title", :description => "Description")
    assert_equal true, MatcherSearcher.match(object, FavorSearcher.valid_searchable_attributes, "Ti")
  end

  test 'match with description' do
    object = stub(:title => "Title", :description => "Description")
    assert_equal true, MatcherSearcher.match(object, FavorSearcher.valid_searchable_attributes, "Desc")
  end

  test 'doesnt match' do
    object = stub(:title => "Title", :description => "Description")
    assert_equal false, MatcherSearcher.match(object, FavorSearcher.valid_searchable_attributes, "Other")
  end

  test 'doesnt match without right fields' do
    object = stub(:title => "Title", :description => "Description")
    assert_equal false, MatcherSearcher.match(object, FavorSearcher.valid_searchable_attributes, "Other")
  end


end




