require_relative "test_helper"

class Norma19Test < Test::Unit::TestCase
  def test_generate_file
    opts = JSON.parse( File.read( "#{FIXTURES}/opts.json" ), :symbolize_names => true)
    payers = JSON.parse( File.read( "#{FIXTURES}/payers.json" ), :symbolize_names => true )

    Delorean.time_travel_to( "2012-09-20" ) do
      assert_equal( read_spaced_fixture( "norma19.txt" ), Norma19.generate_file( opts, payers ) )
    end
  end

  def test_generate_file_with_errors
    opts = {}
    payers = {}

    exception =
      assert_raise( Norma19::ValidatingError ) do
        assert_equal( read_spaced_fixture( "norma19.txt" ), Norma19.generate_file( opts, payers ) )
      end

    assert_not_nil( exception.errors[:opts] )
    assert_not_nil( exception.errors[:payers] )
  end
end
