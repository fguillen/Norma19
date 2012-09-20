class Norma19::Base
  attr_reader :opts, :payers

  def initialize( opts, payers )
    @opts = opts
    @payers = payers

    @opts = @opts.merge( generate_extra_opts )
    @payers = sort_payers( @payers )
  end

  def generate_extra_opts
    total_records_collector = @payers.map { |e| !e[:entry_2] && !e[:entry_4] && !e[:entry_4] ? 1 : 2 }.reduce( &:+ ) + 2
    total_amount = @payers.map { |e| e[:amount] }.reduce( &:+ )

    {
      :file_created_at => Time.now.strftime( "%Y-%m-%d" ),
      :total_payers => @payers.length.to_s,
      :total_records_collector => total_records_collector.to_s,
      :total_records => (total_records_collector + 2).to_s,
      :total_amount => total_amount
    }
  end

  def sort_payers( payers )
    # Dentro de cada cliente ordenante, todos los registros individuales deberán figurar en el
    # fichero clasificados, ascendentemente, por el número de la Entidad - Oficina de adeudo,
    # referencia y ”código de dato”, terminando con un registro de "Total ordenante"

    payers.sort { |x, y| "#{x[:payer_bank_account][0,8]}#{x[:payer_reference_code]}" <=> "#{y[:payer_bank_account][0,8]}#{y[:payer_reference_code]}" }
  end

  def validate_opts
    errors = []

    # collector_nif
    errors << "'collector_nif' can't be empty" if !opts[:collector_nif] || opts[:collector_nif].empty?
    errors << "'collector_nif' can't be bigger than 9 characters" if opts[:collector_nif] && opts[:collector_nif].length > 9

    # file_created_at
    errors << "'file_created_at' can't be empty" if !opts[:file_created_at] || opts[:file_created_at].empty?

    # collector_name
    errors << "'collector_name' can't be empty" if !opts[:collector_name] || opts[:collector_name].empty?
    errors << "'collector_name' can't be bigger than 40 characters" if opts[:collector_name] && opts[:collector_name].length > 40

    # collector_bank_account
    errors << "'collector_bank_account' can't be empty" if !opts[:collector_bank_account] || opts[:collector_bank_account].empty?
    errors << "'collector_bank_account' has to be 20 characters" if opts[:collector_bank_account] && opts[:collector_bank_account].length != 20

    # recipient_bank_entity
    errors << "'recipient_bank_entity' can't be empty" if !opts[:recipient_bank_entity] || opts[:recipient_bank_entity].empty?
    errors << "'recipient_bank_entity' has to be 4 characters" if opts[:recipient_bank_entity] && opts[:recipient_bank_entity].length != 4

    # recipient_bank_office
    errors << "'recipient_bank_office' can't be empty" if !opts[:recipient_bank_office] || opts[:recipient_bank_office].empty?
    errors << "'recipient_bank_office' has to be 4 characters" if opts[:recipient_bank_office] && opts[:recipient_bank_office].length != 4

    # total_amount
    errors << "'total_amount' can't be empty" if !opts[:total_amount]

    # total_payers
    errors << "'total_payers' can't be empty" if !opts[:total_payers] || opts[:total_payers].empty?

    # total_records_collector
    errors << "'total_records_collector' can't be empty" if !opts[:total_records_collector] || opts[:total_records_collector].empty?

    # total_records
    errors << "'total_records' can't be empty" if !opts[:total_records] || opts[:total_records].empty?

    errors
  end

  def validate_payers
    errors = []

    payers.each_with_index do |payer, index|
      errors_payer = []
      # payer_reference_code
      errors_payer << "'payer_reference_code' can't be empty" if !payer[:payer_reference_code] || payer[:payer_reference_code].empty?
      errors_payer << "'payer_reference_code' has to be 12 characters" if payer[:payer_reference_code] && payer[:payer_reference_code].length > 12

      # payer_name
      errors_payer << "'payer_name' can't be empty" if !payer[:payer_name] || payer[:payer_name].empty?
      errors_payer << "'payer_name' can't be bigger than 40 characters" if payer[:payer_name] && payer[:payer_name].length > 40

      # payer_bank_account
      errors_payer << "'payer_bank_account' can't be empty" if !payer[:payer_bank_account] || payer[:payer_bank_account].empty?
      errors_payer << "'payer_bank_account' has to be 20 characters" if payer[:payer_bank_account] && payer[:payer_bank_account].length != 20

      # amount
      errors_payer << "'amount' can't be empty" if !payer[:amount]

      # entry_1
      errors_payer << "'entry_1' can't be empty" if !payer[:entry_1] || payer[:entry_1].empty?
      errors_payer << "'entry_1' can't be bigger than 40 characters" if payer[:entry_1] && payer[:entry_1].length > 40

      # entry_2
      errors_payer << "'entry_2' can't be bigger than 40 characters" if payer[:entry_2] && payer[:entry_2].length > 40

      # entry_3
      errors_payer << "'entry_3' can't be bigger than 40 characters" if payer[:entry_3] && payer[:entry_3].length > 40

      # entry_4
      errors_payer << "'entry_4' can't be bigger than 40 characters" if payer[:entry_4] && payer[:entry_4].length > 40

      errors << { :payer_index => index, :errors => errors_payer } unless errors_payer.empty?
    end

    errors
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

    result.join( "\n" )
  end
end