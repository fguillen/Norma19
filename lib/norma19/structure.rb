# encoding: utf-8

# official documentation: http://multimedia.lacaixa.es/lacaixa/ondemand/empresa/filetransfer/Q19.pdf

class Norma19::Structure
  attr_reader :opts, :payers

  HEAD_1 = [
    { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "51" },
    { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "80" },
    { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
    { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
    { :name => :file_created_at, :description => "fecha confección soporte", :type => :date, :size => 6 },
    { :name => :free, :description => "libre", :type => :empty, :size => 6 },
    { :name => :collector_name, :description => "nombre del cliente ordenante", :type => :string, :size => 40 },
    { :name => :free, :description => "libre", :type => :empty, :size => 20 },
    { :name => :bank_entity, :description => "entidad receptora fichero", :type => :numeric, :size => 4 },
    { :name => :bank_office, :description => "oficina receptora fichero", :type => :numeric, :size => 4 },
    { :name => :free, :description => "libre", :type => :empty, :size => 12 },
    { :name => :free, :description => "libre", :type => :empty, :size => 40 },
    { :name => :free, :description => "libre", :type => :empty, :size => 14 }
  ]

  HEAD_2 = [
    { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "53" },
    { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "80" },
    { :name => :collector_nif,:description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
    { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
    { :name => :file_created_at, :description => "fecha confección soporte", :type => :date, :size => 6 },
    { :name => :pay_at, :description => "fecha pago", :type => :date, :size => 6 },
    { :name => :collector_name, :description => "nombre del cliente ordenante", :type => :string, :size => 40 },
    { :name => :collector_bank_account, :description => "cuenta de banco del ordenante", :type => :string, :size => 20 },
    { :name => :free, :description => "libre", :type => :empty, :size => 8 },
    { :name => :procedure_type, :description => "tipo de procedimiento", :type => :numeric, :size => 2, :value => "01" },
    { :name => :free, :description => "libre", :type => :empty, :size => 10 },
    { :name => :free, :description => "libre", :type => :empty, :size => 40 },
    { :name => :free, :description => "libre", :type => :empty, :size => 14 }
  ]

  PAYER_1 = [
    { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "56" },
    { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "80" },
    { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
    { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
    { :name => :payer_reference_code, :description => "código de referencia", :type => :alphanumeric, :size => 12 },
    { :name => :payer_name, :description => "nombre del titular de la domiciliación", :type => :string, :size => 40 },
    { :name => :payer_bank_account, :description => "cuenta de domiciliación", :type => :numeric, :size => 20 },
    { :name => :amount, :description => "importe", :type => :currency, :size => 10 },
    { :name => :code_for_devolution, :description => "código para devolución", :type => :empty, :size => 6 },
    { :name => :code_for_internal_reference, :description => "código de referencia interna", :type => :empty, :size => 10 },
    { :name => :entry_1, :description => "campo concepto 1", :type => :string, :size => 40 },
    { :name => :free, :description => "libre", :type => :empty, :size => 8 }
  ]

  PAYER_2 = [
    { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "56" },
    { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "81" },
    { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
    { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
    { :name => :payer_reference_code, :description => "código de referencia", :type => :alphanumeric, :size => 12 },
    { :name => :entry_2, :description => "campo concepto 2", :type => :string, :size => 40 },
    { :name => :entry_3, :description => "campo concepto 3", :type => :string, :size => 40 },
    { :name => :entry_4, :description => "campo concepto 4", :type => :string, :size => 40 },
    { :name => :free, :description => "libre", :type => :empty, :size => 14 }
  ]

  # In the official documentation there are even SIX PAYER lines but only the first one is required

  FOOTER_1 = [
    { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "58" },
    { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "80" },
    { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
    { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
    { :name => :free, :description => "libre", :type => :empty, :size => 12 },
    { :name => :free, :description => "libre", :type => :empty, :size => 40 },
    { :name => :free, :description => "libre", :type => :empty, :size => 20 },
    { :name => :total_amount, :description => "suma de importes del ordenante", :type => :currency, :size => 10 },
    { :name => :free, :description => "libre", :type => :empty, :size => 6 },
    { :name => :total_payers, :description => "número de domiciliaciones del ordenante", :type => :numeric, :size => 10 },
    { :name => :total_records_collector, :description => "número total de registros del ordenante", :type => :numeric, :size => 10 },
    { :name => :free, :description => "libre", :type => :empty, :size => 20 },
    { :name => :free, :description => "libre", :type => :empty, :size => 18 }
  ]

  FOOTER_2 = [
    { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "59" },
    { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "80" },
    { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
    { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
    { :name => :free, :description => "libre", :type => :empty, :size => 12 },
    { :name => :free, :description => "libre", :type => :empty, :size => 40 },
    { :name => :collectors_num, :description => "número de ordenantes", :type => :numeric, :size => 4, :value => "1" },
    { :name => :free, :description => "libre", :type => :empty, :size => 16 },
    { :name => :total_amount, :description => "suma de importes", :type => :currency, :size => 10 },
    { :name => :free, :description => "libre", :type => :empty, :size => 6 },
    { :name => :total_payers, :description => "número de domiciliaciones", :type => :numeric, :size => 10 },
    { :name => :total_records, :description => "número total de registros del soporte", :type => :numeric, :size => 10 },
    { :name => :free, :description => "libre", :type => :empty, :size => 20 },
    { :name => :free, :description => "libre", :type => :empty, :size => 18 }
  ]

  def initialize( opts, payers )
    @opts = opts
    @payers = payers
  end

  def validate_opts
    errors = []

    # collector_nif
    errors << "'collector_nif' can't be empty" if !opts[:collector_nif] || opts[:collector_nif].empty?
    errors << "'collector_nif' can't be bigger than 9 characters" if opts[:collector_nif].length > 9

    # file_created_at
    errors << "'file_created_at' can't be empty" if !opts[:file_created_at] || opts[:file_created_at].empty?

    # collector_name
    errors << "'collector_name' can't be empty" if !opts[:collector_name] || opts[:collector_name].empty?
    errors << "'collector_name' can't be bigger than 40 characters" if opts[:collector_name].length > 40

    # collector_bank_account
    errors << "'collector_bank_account' can't be empty" if !opts[:collector_bank_account] || opts[:collector_name].empty?
    errors << "'collector_bank_account' has to be 20 characters" if opts[:collector_bank_account].length != 20

    # total_amount
    errors << "'total_amount' can't be empty" if !opts[:total_amount] || opts[:total_amount].empty?

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

    opts[:payers].each_with_index do |payer, index|
      errors_payer = []
      # payer_reference_code
      errors_payer << "'payer_reference_code' can't be empty" if !opts[:payer_reference_code] || opts[:payer_reference_code].empty?
      errors_payer << "'payer_reference_code' has to be 12 characters" if opts[:payer_reference_code].length > 12

      # payer_name
      errors_payer << "'payer_name' can't be empty" if !opts[:payer_name] || opts[:payer_name].empty?
      errors_payer << "'payer_name' can't be bigger than 40 characters" if opts[:payer_name].length > 40

      # payer_bank_account
      errors_payer << "'payer_bank_account' can't be empty" if !opts[:payer_bank_account] || opts[:payer_bank_account].empty?
      errors_payer << "'payer_bank_account' has to be 20 characters" if opts[:payer_bank_account].length != 20

      # amount
      errors_payer << "'amount' can't be empty" if !opts[:amount] || opts[:amount].empty?

      # entry_1
      errors_payer << "'entry_1' can't be empty" if !opts[:entry_1] || opts[:entry_1].empty?
      errors_payer << "'entry_1' can't be bigger than 40 characters" if opts[:entry_1].length > 40

      # entry_2
      errors_payer << "'entry_2' can't be bigger than 40 characters" if opts[:entry_2].length > 40

      # entry_3
      errors_payer << "'entry_3' can't be bigger than 40 characters" if opts[:entry_3].length > 40

      # entry_4
      errors_payer << "'entry_4' can't be bigger than 40 characters" if opts[:entry_4].length > 40

      errors << { :payer_index => index, :errors => errors_payer } unless errors_payer.empty?
    end

    errors
  end

  def generate_head_1
    HEAD_1.map do |field|
      Norma19::FieldRenderer.generate_field( field, opts )
    end.join
  end

end