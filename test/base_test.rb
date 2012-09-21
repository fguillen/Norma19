require_relative "test_helper"

class Norma19::BaseTest < Test::Unit::TestCase
  def setup
    opts = JSON.parse( File.read( "#{FIXTURES}/opts.json" ), :symbolize_names => true)
    payers = JSON.parse( File.read( "#{FIXTURES}/payers.json" ), :symbolize_names => true )

    @norma19 = Norma19::Base.new( opts, payers )
  end

  def test_initialize
    norma19 = Norma19::Base.new( "opts", "payers" )

    assert_equal( "opts", norma19.opts )
    assert_equal( "payers", norma19.payers )
  end

  def test_sort_payers
    assert_equal( ["1001", "1002", "1003"], @norma19.payers.map { |e| e[:payer_reference_code] } )
    @norma19.sort_payers
    assert_equal( ["1001", "1003", "1002"], @norma19.payers.map { |e| e[:payer_reference_code] } )
  end


  def test_generate_extra_opts
    Delorean.time_travel_to( "2001-02-03" ) do
      @norma19.generate_extra_opts
      assert_equal( "2001-02-03", @norma19.opts[:file_created_at] )
      assert_equal( "3", @norma19.opts[:total_payers] )
      assert_equal( "7", @norma19.opts[:total_records_collector] )
      assert_equal( "9", @norma19.opts[:total_records] )
      assert_equal( 200011.01, @norma19.opts[:total_amount] )
    end
  end

  def test_validate_opts
    assert_equal( true, @norma19.validate_opts.empty? )
  end

  def test_validate_payers
    assert_equal( true, @norma19.validate_payers.empty? )
  end

  def test_validate
    assert_equal( true, @norma19.validate.empty? )
  end

  def test_validate_with_errors
    opts = {}
    payers = [{}]

    norma19 = Norma19::Base.new( opts, payers )
    errors = norma19.validate

    assert_equal( 6, errors[:opts].length )
    assert_equal( 1, errors[:payers].length )
    assert_equal( 5, errors[:payers].first[:errors].length )
    assert_equal( 0, errors[:payers].first[:index] )
  end

  def test_generate_file
    Delorean.time_travel_to( "2012-09-20" ) do
      @norma19.generate_extra_opts
      @norma19.sort_payers
      assert_equal( read_spaced_fixture( "norma19.txt" ), @norma19.generate_file )
    end
  end

end