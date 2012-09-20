require_relative "test_helper"

class Norma19::BaseTest < Test::Unit::TestCase
  def setup
  end

  def test_initialize
    assert_equal( "opts", Norma19::Base.new( "conf", "payers" ).opts )
    assert_equal( "payers", Norma19::Base.new( "conf", "payers" ).payers )
  end

  def test_generate_file
    conf = JSON.load( "#{FIXTURES}/conf.json" )
    payers = JSON.load( "#{FIXTURES}/payers.json" )

    norma19 = Norma19::Base.new( conf, payers ).opts
    puts norma19.generate_file
  end
end