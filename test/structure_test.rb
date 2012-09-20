require_relative "test_helper"

class Norma19::StructureTest < Test::Unit::TestCase
  def test_all_lines_total_sizes
    assert_equal( 162, Norma19::Structure::STRUCTURES[:head_1].map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::STRUCTURES[:head_2].map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::STRUCTURES[:payer_1].map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::STRUCTURES[:payer_2].map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::STRUCTURES[:footer_1].map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::STRUCTURES[:footer_2].map{ |e| e[:size] }.reduce(:+) )
  end
end