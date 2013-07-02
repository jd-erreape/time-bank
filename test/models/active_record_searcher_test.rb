require 'test_helper'
require 'mocha/setup'

class ActiveRecordSearcherTest < ActiveSupport::TestCase
  test 'build conditions' do
    fields = [:title, :description]
    query = "testing"
    assert_equal "title LIKE '%testing%' OR description LIKE '%testing%'",
                 ActiveRecordSearcher.build_conditions(fields, query)
  end

  test 'find' do
    favor_attributes = {:title => "Title"}
    favor = Favor.create(favor_attributes)
    active_record_searcher = ActiveRecordSearcher.new(:bag => Favor)
    assert_equal [favor], active_record_searcher.find(FavorSearcher.valid_searchable_attributes, "Ti")
  end

end




