class Norma19::FieldRenderer
  def self.render_field( field, opts )
    puts "XXX: field: #{field}"

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
      render_alphanumeric( opts[field[:name]] )

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


end