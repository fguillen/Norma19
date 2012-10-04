# encoding: iso-8859-1

require_relative "test_helper"

class Norma19::LineRendererTest < Test::Unit::TestCase
  def setup
    @opts = JSON.parse( File.read( "#{FIXTURES}/opts.json" ), :symbolize_names => true)
    @payers = JSON.parse( File.read( "#{FIXTURES}/payers.json" ), :symbolize_names => true )

    extra_opts = {
      :file_created_at => "2001-02-03",
      :total_payers => "3",
      :total_records_collector => "7",
      :total_records => "9",
      :total_amount => 200011.01
    }

    @opts = @opts.merge( extra_opts )
  end

  def test_render_head_1
    assert_equal( read_spaced_fixture( "head_1.txt" ), Norma19::LineRenderer.render_head_1( @opts ) )
  end

  def test_render_head_2
    assert_equal( read_spaced_fixture( "head_2.txt" ), Norma19::LineRenderer.render_head_2( @opts ) )
  end

  def test_render_footer_1
    assert_equal( read_spaced_fixture( "footer_1.txt" ), Norma19::LineRenderer.render_footer_1( @opts ) )
  end

  def test_render_footer_2
    assert_equal( read_spaced_fixture( "footer_2.txt" ), Norma19::LineRenderer.render_footer_2( @opts ) )
  end

  def test_render_payer_1
    # write_spaced_fixture( "payer_1.txt", Norma19::LineRenderer.render_payer( @opts, @payers.first ) )
    assert_equal( read_spaced_fixture( "payer_1.txt" ), Norma19::LineRenderer.render_payer( @opts, @payers.first ) )
  end

  def test_render_payer_3
    assert_equal( read_spaced_fixture( "payer_3.txt" ), Norma19::LineRenderer.render_payer( @opts, @payers.last ) )
  end
end