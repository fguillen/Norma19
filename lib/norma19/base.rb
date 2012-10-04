class Norma19::Base
  attr_reader :opts, :payers

  def initialize( opts, payers )
    @opts = opts
    @payers = payers
  end

  def generate_extra_opts
    total_records_collector = @payers.map { |e| (!e[:entry_2] && !e[:entry_4] && !e[:entry_4]) ? 1 : 2 }.reduce( &:+ ) + 2
    total_amount = @payers.map { |e| e[:amount] }.reduce( &:+ )

    opts.merge!({
      :file_created_at => Time.now.strftime( "%Y-%m-%d" ),
      :total_payers => @payers.length.to_s,
      :total_records_collector => total_records_collector.to_s,
      :total_records => (total_records_collector + 2).to_s,
      :total_amount => total_amount
    })
  end

  def sort_payers
    # Dentro de cada cliente ordenante, todos los registros individuales deberán figurar en el
    # fichero clasificados, ascendentemente, por el número de la Entidad - Oficina de adeudo,
    # referencia y ”código de dato”, terminando con un registro de "Total ordenante"

    payers.sort! { |x, y| "#{x[:payer_bank_account][0,8]}#{x[:payer_reference_code]}" <=> "#{y[:payer_bank_account][0,8]}#{y[:payer_reference_code]}" }
  end

  def validate_opts
    opts_errors = []

    # collector_nif
    opts_errors << "'collector_nif' can't be empty" if !opts[:collector_nif] || opts[:collector_nif].empty?
    opts_errors << "'collector_nif' can't be bigger than 9 characters: '#{payer[:collector_nif]}'" if opts[:collector_nif] && opts[:collector_nif].length > 9

    # collector_name
    opts_errors << "'collector_name' can't be empty" if !opts[:collector_name] || opts[:collector_name].empty?
    opts_errors << "'collector_name' can't be bigger than 40 characters: '#{payer[:collector_name]}'" if opts[:collector_name] && opts[:collector_name].length > 40

    # collector_bank_account
    opts_errors << "'collector_bank_account' can't be empty" if !opts[:collector_bank_account] || opts[:collector_bank_account].empty?
    opts_errors << "'collector_bank_account' has to be 20 characters: '#{payer[:collector_bank_account]}'" if opts[:collector_bank_account] && opts[:collector_bank_account].length != 20

    # recipient_bank_entity
    opts_errors << "'recipient_bank_entity' can't be empty" if !opts[:recipient_bank_entity] || opts[:recipient_bank_entity].empty?
    opts_errors << "'recipient_bank_entity' has to be 4 characters: '#{payer[:recipient_bank_entity]}'" if opts[:recipient_bank_entity] && opts[:recipient_bank_entity].length != 4

    # recipient_bank_office
    opts_errors << "'recipient_bank_office' can't be empty" if !opts[:recipient_bank_office] || opts[:recipient_bank_office].empty?
    opts_errors << "'recipient_bank_office' has to be 4 characters: '#{payer[:recipient_bank_office]}'" if opts[:recipient_bank_office] && opts[:recipient_bank_office].length != 4

    # pay_at
    opts_errors << "'pay_at' can't be empty" if !opts[:pay_at] || opts[:pay_at].empty?

    opts_errors
  end

  def validate_payers
    payers_errors = []

    payers.each_with_index do |payer, index|
      payer_errors = []
      # payer_reference_code
      payer_errors << "'payer_reference_code' can't be empty" if !payer[:payer_reference_code] || payer[:payer_reference_code].empty?
      payer_errors << "'payer_reference_code' has to be 12 characters: '#{payer[:payer_reference_code]}'" if payer[:payer_reference_code] && payer[:payer_reference_code].length > 12

      # payer_name
      payer_errors << "'payer_name' can't be empty" if !payer[:payer_name] || payer[:payer_name].empty?
      payer_errors << "'payer_name' can't be bigger than 40 characters: '#{payer[:payer_name]}'" if payer[:payer_name] && payer[:payer_name].length > 40

      # payer_bank_account
      payer_errors << "'payer_bank_account' can't be empty" if !payer[:payer_bank_account] || payer[:payer_bank_account].empty?
      payer_errors << "'payer_bank_account' has to be 20 characters: '#{payer[:payer_bank_account]}'" if payer[:payer_bank_account] && payer[:payer_bank_account].length != 20

      # amount
      payer_errors << "'amount' can't be empty" if !payer[:amount]

      # entry_1
      payer_errors << "'entry_1' can't be empty" if !payer[:entry_1] || payer[:entry_1].empty?
      payer_errors << "'entry_1' can't be bigger than 40 characters: '#{payer[:entry_1]}'" if payer[:entry_1] && payer[:entry_1].length > 40

      # entry_2
      payer_errors << "'entry_2' can't be bigger than 40 characters: '#{payer[:entry_2]}'" if payer[:entry_2] && payer[:entry_2].length > 40

      # entry_3
      payer_errors << "'entry_3' can't be bigger than 40 characters: '#{payer[:entry_3]}'" if payer[:entry_3] && payer[:entry_3].length > 40

      # entry_4
      payer_errors << "'entry_4' can't be bigger than 40 characters: '#{payer[:payer_name]}'" if payer[:entry_4] && payer[:entry_4].length > 40

      payers_errors << { :index => index, :payer => payer, :errors => payer_errors } unless payer_errors.empty?
    end

    payers_errors << { :index => 0, :payer => "-", :errors => "'payers' empty!" } if payers.empty?

    payers_errors
  end

  def validate
    errors = {
      :opts => validate_opts,
      :payers => validate_payers
    }

    return {} if errors[:opts].empty? && errors[:payers].empty?
    return errors
  end

  def generate_file
    result = []

    result << Norma19::LineRenderer.render_head_1( opts )
    result << Norma19::LineRenderer.render_head_2( opts )

    payers.each do |payer|
      result << Norma19::LineRenderer.render_payer( opts, payer )
    end

    result << Norma19::LineRenderer.render_footer_1( opts )
    result << Norma19::LineRenderer.render_footer_2( opts )

    result.join( "\r\n" ).encode( "ISO-8859-1" )
  end
end