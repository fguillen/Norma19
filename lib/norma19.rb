require "json"

require_relative "norma19/version"
require_relative "norma19/logger"
require_relative "norma19/base"
require_relative "norma19/structure"
require_relative "norma19/field_renderer"
require_relative "norma19/line_renderer"
require_relative "norma19/validating_exception"

module Norma19
  def self.generate_file( opts, payers )
    norma19 = Norma19::Base.new( opts, payers )

    errors = norma19.validate
    raise Norma19::ValidatingException, errors unless errors.empty?

    norma19.generate_extra_opts
    norma19.sort_payers
    norma19.generate_file
  end
end