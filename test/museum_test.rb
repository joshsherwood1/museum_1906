require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'
class MuseumTest < Minitest::Test
  def setup
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
    @imax = Exhibit.new("IMAX", 15)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dmns = Museum.new("Denver Museum of Nature and Science")
  end

  def test_that_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_that_it_has_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_that_museum_has_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_that_museum_recommends_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")
    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_that_museum_has_no_patrons
    assert_equal [], @dmns.patrons
  end

  def test_that_museum_has_patrons
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_to_find_patrons_by_exhibit_interest

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)
    @dmns.admit(@sally)

    expected = {

      @dead_sea_scrolls => [@bob, @sally],
      @gems_and_minerals => [@bob],
      @imax => []

    }
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end

  def test_find_patrons
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    assert_equal [@bob], @dmns.find_patrons(@gems_and_minerals)
  end
end
