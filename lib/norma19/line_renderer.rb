# encoding: iso-8859-1

module Norma19::LineRenderer
  def self.render_line( structure_name, opts )
    Norma19::Structure::STRUCTURES[structure_name].map { |field| Norma19::FieldRenderer.render_field( field, opts ) }.join
  end

  def self.render_head_1( opts )
    render_line( :head_1, opts )
  end

  def self.render_head_2( opts )
    render_line( :head_2, opts )
  end

  def self.render_footer_1( opts )
    render_line( :footer_1, opts )
  end

  def self.render_footer_2( opts )
    render_line( :footer_2, opts )
  end

  def self.render_payer( opts, payer )
    all_opts = opts.merge( payer )

    result = render_line( :payer_1, all_opts )

    if( payer[:entry_2] || payer[:entry_3] || payer[:entry_4]  )
      result += "\r\n#{render_line( :payer_2, all_opts )}"
    end

    result.encode( "ISO-8859-1" )
  end

end