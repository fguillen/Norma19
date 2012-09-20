require_relative "test_helper"

class Norma19::BaseTest < Test::Unit::TestCase
  def setup
    opts = JSON.parse( File.read( "#{FIXTURES}/opts.json" ), :symbolize_names => true)
    payers = JSON.parse( File.read( "#{FIXTURES}/payers.json" ), :symbolize_names => true )

    @norma19 = Norma19::Base.new( opts, payers )
  end

  def test_initialize
    Norma19::Base.any_instance.expects( :generate_extra_opts ).returns( { :key_extra => "value_extra" } )
    opts = { :key_1 => "value_1" }
    payers = JSON.parse( File.read( "#{FIXTURES}/payers.json" ), :symbolize_names => true )

    norma19 = Norma19::Base.new( opts, payers )

    assert_equal( "value_1", norma19.opts[:key_1] )
    assert_equal( "value_extra", norma19.opts[:key_extra] )
    assert_equal( ["1001", "1003", "1002"], norma19.payers.map { |e| e[:payer_reference_code] } )
  end


  def test_generate_extra_opts
    Delorean.time_travel_to( "2001-02-03" ) do
      extra_opts = @norma19.generate_extra_opts
      assert_equal( "2001-02-03", extra_opts[:file_created_at] )
      assert_equal( "3", extra_opts[:total_payers] )
      assert_equal( "7", extra_opts[:total_records_collector] )
      assert_equal( "9", extra_opts[:total_records] )
      assert_equal( 200011.01, extra_opts[:total_amount] )
    end
  end

  def test_validate_opts
    assert_equal( true, @norma19.validate_opts.empty? )
  end

  def test_validate_payers
    assert_equal( true, @norma19.validate_payers.empty? )
  end

  def test_generate_file
    assert_equal( read_spaced_fixture( "norma19.txt" ), @norma19.generate_file )
  end

end