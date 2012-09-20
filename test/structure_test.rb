require_relative "test_helper"

class Norma19::StructureTest < Test::Unit::TestCase
  def test_all_lines_total_sizes
    assert_equal( 162, Norma19::Structure::HEAD_1.map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::HEAD_2.map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::PAYER_1.map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::PAYER_2.map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::FOOTER_1.map{ |e| e[:size] }.reduce(:+) )
    assert_equal( 162, Norma19::Structure::FOOTER_2.map{ |e| e[:size] }.reduce(:+) )
  end
end