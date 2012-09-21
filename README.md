# Norma19

Norma19 file generator.

Check official documentation about this files here: http://multimedia.lacaixa.es/lacaixa/ondemand/empresa/filetransfer/Q19.pdf

## Installation

Add this line to your application's Gemfile:

    gem "norma19"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install norma19

## Usage

For example I have in a Rails application:

    class Norma19Export
      def self.export( members )
        opts = {
          :collector_nif => "X12123123",
          :collector_name => "Asociacio Pro-TapWater",
          :collector_bank_account => "11113333445555555555",
          :recipient_bank_entity => "1200",
          :recipient_bank_office => "2366",
          :pay_at => (Time.now + 2.days).strftime( "%Y-%m-%d" )
        }

        payers = generate_payers( members )

        Norma19.generate_file( opts, payers )
      end

      def self.generate_payers( members )
        members.map do |member|
          payer = {
            :payer_nif => member.dni,
            :payer_reference_code => member.id.to_s,
            :payer_name => member.full_name,
            :payer_bank_account => member.bank_account,
            :amount => member.fee_amount,
            :entry_1 => "Asociation Member Fee"
          }
        end
      end
    end

And I can use it like this:

    Norma19Export.export( Member.all )


## TODO

* Works for only one _"ordenante"_.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
