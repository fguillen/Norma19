# encoding: utf-8

# official documentation: http://multimedia.lacaixa.es/lacaixa/ondemand/empresa/filetransfer/Q19.pdf

class Norma19::Structure
  STRUCTURES = {
    :head_1 => [
      { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "51" },
      { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "80" },
      { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
      { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
      { :name => :file_created_at, :description => "fecha confección soporte", :type => :date, :size => 6 },
      { :name => :free, :description => "libre", :type => :empty, :size => 6 },
      { :name => :collector_name, :description => "nombre del cliente ordenante", :type => :string, :size => 40 },
      { :name => :free, :description => "libre", :type => :empty, :size => 20 },
      { :name => :recipient_bank_entity, :description => "entidad receptora fichero", :type => :numeric, :size => 4 },
      { :name => :recipient_bank_office, :description => "oficina receptora fichero", :type => :numeric, :size => 4 },
      { :name => :free, :description => "libre", :type => :empty, :size => 12 },
      { :name => :free, :description => "libre", :type => :empty, :size => 40 },
      { :name => :free, :description => "libre", :type => :empty, :size => 14 }
    ],

    :head_2 => [
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
    ],

    :payer_1 => [
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
    ],

    :payer_2 => [
      { :name => :entry_code, :description => "código de registro", :type => :numeric, :size => 2, :value => "56" },
      { :name => :data_code, :description => "código de dato", :type => :numeric, :size => 2, :value => "81" },
      { :name => :collector_nif, :description => "nif de ordenante", :type => :alphanumeric, :size => 9 },
      { :name => :collector_sufix, :description => "sufijo de ordenante", :type => :alphanumeric, :size => 3, :value => "0" },
      { :name => :payer_reference_code, :description => "código de referencia", :type => :alphanumeric, :size => 12 },
      { :name => :entry_2, :description => "campo concepto 2", :type => :string, :size => 40, :optional => true },
      { :name => :entry_3, :description => "campo concepto 3", :type => :string, :size => 40, :optional => true },
      { :name => :entry_4, :description => "campo concepto 4", :type => :string, :size => 40, :optional => true },
      { :name => :free, :description => "libre", :type => :empty, :size => 14 }
    ],

    # In the official documentation there are even SIX PAYER lines but only the first one is required

    :footer_1 => [
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
    ],

    :footer_2 => [
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
  }

end