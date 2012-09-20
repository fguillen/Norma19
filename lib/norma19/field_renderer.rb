module Norma19::FieldRenderer
  def self.render_field( field, opts )
    type = field[:type]
    value = field[:value] || opts[field[:name]]
    size = field[:size]
    optional = field[:optional]

    return render_empty( size ) if !value && optional

    case type
    when :empty
      render_empty( size )

    when :numeric
      render_numeric( value, size )

    when :string
      render_string( value, size )

    when :alphanumeric
      render_alphanumeric( value, size )

    when :date
      render_date( value )

    when :currency
      render_currency( value, size )

    end
  end

  def self.render_empty( size )
    " " * size
  end

  def self.render_string( string, size )
    string.upcase.ljust( size )
  end

  def self.render_alphanumeric( string, size )
    string.upcase.rjust( size, "0" )
  end

  def self.render_numeric( string, size )
    string.rjust( size, "0" )
  end

  def self.render_date( string )
    splits = string.split( "-" )
    "#{splits[2]}#{splits[1]}#{splits[0][2,2]}"
  end

  def self.render_currency( float, size )
    sprintf( "%.2f", float ).gsub( ".", "" ).rjust( size, "0" )
  end


end