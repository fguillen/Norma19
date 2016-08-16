require "test/unit"
require "mocha/test_unit"
require "delorean"
require_relative "../lib/norma19"

module TestHelper
  FIXTURES = File.expand_path( "#{File.dirname(__FILE__)}/fixtures" )

  def read_fixture( fixture_name )
    File.read( "#{FIXTURES}/#{fixture_name}" )
  end

  def write_spaced_fixture( fixture_name, content )
    puts "ATTENTION: fixture been written"
    File.open( "#{FIXTURES}/#{fixture_name}", "w:iso-8859-1" ) { |f| f.write content.gsub( ".", " " ) }
  end

  def read_spaced_fixture( fixture_name )
    f = File.open( "#{FIXTURES}/#{fixture_name}", "r:iso-8859-1" )
    f.read.gsub( ".", " " )
  end

  def in_tmpdir
    path = File.expand_path "#{Dir.tmpdir}/#{Time.now.to_i}_#{rand(1000)}/"
    FileUtils.mkdir_p( path )

    yield( path )

  ensure
    FileUtils.rm_rf( path ) if File.exists?( path )
  end
end

class Test::Unit::TestCase
  include TestHelper

  def setup
    Norma19::Logger.stubs( :log )
  end
end

