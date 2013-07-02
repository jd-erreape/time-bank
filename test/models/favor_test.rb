require 'test_helper'

class FavorTest < ActiveSupport::TestCase
  test 'nil basic favor' do
    favor = Favor.new
    assert_equal favor.title, nil
    assert_equal favor.description, nil
    assert_equal favor.time, nil
  end

  test 'fill basic favor information' do
    favor = Favor.new(title: 'Basic Title', description: 'Basic Description', time: 60)
    assert_equal favor.title, 'Basic Title'
    assert_equal favor.description, 'Basic Description'
    assert_equal favor.time, 60
  end
end
