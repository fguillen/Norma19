module Norma19
  module Logger
    def self.log( message )
      Kernel.puts "[Norma19 #{Time.now.strftime( "%F %T" )}] #{message}"
    end
  end
end