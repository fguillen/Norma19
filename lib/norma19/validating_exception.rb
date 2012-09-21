class Norma19::ValidatingException < Exception
  attr_reader :errors

  def initialize( errors )
    @errors = errors
  end

  def to_s
    @errors.to_s
  end
end