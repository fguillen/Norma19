# encoding: utf-8

require_relative "test_helper"

class Norma19::FieldRendererTest < Test::Unit::TestCase
  def test_render_empty
    assert_equal( "", Norma19::FieldRenderer.render_empty( 0 ) )
    assert_equal( " ", Norma19::FieldRenderer.render_empty( 1 ) )
    assert_equal( "      ", Norma19::FieldRenderer.render_empty( 6 ) )
  end

  def test_render_string
    assert_equal( "    ", Norma19::FieldRenderer.render_string( "", 4 ) )
    assert_equal( "HELLO     ", Norma19::FieldRenderer.render_string( "hello", 10 ) )
    assert_equal( "áAAéEEñ   ", Norma19::FieldRenderer.render_string( "áAaéEeñ", 10 ) )
  end

  def test_render_alphanumeric
    assert_equal( "0000", Norma19::FieldRenderer.render_alphanumeric( "", 4 ) )
    assert_equal( "00000HELLO", Norma19::FieldRenderer.render_alphanumeric( "hello", 10 ) )
    assert_equal( "000áAAéEEñ", Norma19::FieldRenderer.render_alphanumeric( "áAaéEeñ", 10 ) )
  end

  def test_render_numeric
    assert_equal( "0000", Norma19::FieldRenderer.render_numeric( "0", 4 ) )
    assert_equal( "0001", Norma19::FieldRenderer.render_numeric( "1", 4 ) )
    assert_equal( "1234", Norma19::FieldRenderer.render_numeric( "1234", 4 ) )
    assert_equal( "001234", Norma19::FieldRenderer.render_numeric( "1234", 6 ) )
  end

  def test_render_date
    assert_equal( "310112", Norma19::FieldRenderer.render_date( "2012-01-31" ) )
  end

  # def test_render_field
  #   field = { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
  #   opts = { :collector_nif => "NIF1212" }

  #   assert_equal( "00NIF1212", Norma19::FieldRenderer.render_field( field, opts ) )
  # end
end