class Norma19::FieldRenderer
  def self.render_field( field, opts )
    puts "XXX: field: #{field}"
    puts "XXX: opt: #{opts}"

    case field[:type]
    when :empty
      render_empty( field[:size] )

    when :numeric
      render_numeric( field[:value] || opts[field[:name]], field[:size] )

    when :string
      render_string( field[:value] || opts[field[:name]], field[:size] )

    when :alphanumeric
      render_alphanumeric( field[:value] || opts[field[:name]], field[:size] )

    when :date
      render_date( opts[field[:name]] )

    when :currency
      render_currency( opts[field[:name]], field[:size] )

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
    string.upcase.rjust( size, "0" )
  end

  def self.render_date( string )
    splits = string.split( "-" )
    "#{splits[2]}#{splits[1]}#{splits[0][2,2]}"
  end

  def self.render_currency( float, size )
    sprintf( "%.2f", float ).gsub( ".", "" ).rjust( size, "0" )
  end


end