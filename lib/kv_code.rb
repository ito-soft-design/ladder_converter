require 'plc_code'

module LadderConvertor


  class KvCode < PlcCode

    def to_s
      return mnemonic if devices.empty?
      ([mnemonic] + devices).join(" ")
    end

    private

      def own_mnemonic mnemonic
        mnemonic.upcase!
        case mnemonic

        when "MPP"
          mnemonic
        when 'ANDP'
          'ANP'
        when /(.+)P$/
          "#{own_mnemonic($1)}P"

        when "PLF"
          "DIFD"
        when 'ANDF'
          'ANF'
        when /(.+)F$/
          "#{own_mnemonic($1)}F"

        when "DIV"
          "CAL/"
        when /^D(.+)/
          "#{own_mnemonic($1)}.D"

        when 'LD', 'OUT', 'END', 'AND', 'OR', 'SET',
             'MPS', 'MRD', 'MPP',
             'MOV'
          mnemonic
        else
          n = {
            'LDI' => 'LDB',
            "ANI"   => "ANB",
            "ORI"   => "ORB",
            "ANB"   => "ANL",
            "ORB"   => "ORL",
            "PLS"   => "DIFU",
            "PLF"   => "DIFD",
            "RST"   => "RES",
          
            "ADD"   => "CAL+",
            "SUB"   => "CAL-",
            "MUL"   => "CAL*",
            "DIV"   => "CAL/",

          }[mnemonic]
          if n
            n
          else
            raise "Unknown mnemonic #{mnemonic}!"
          end
        end
      end

      def own_device device
        case device
        when /^M8000$/i # 常時ON
          "CR2002"
        when /^M8001$/i # 常時OFF
          "CR2003"
        when /^([A-Z]+.+)(Z\d+)/
          "#{$1}:#{conv_dev $2}"
        when /^Z(\d+)$/
          "Z#{($1.to_i + 1).to_s.rjust(2, '0')}"
        when /^MR|^DM/i
          device
        when /(^M)(\d+)/i
          n = $2.to_i
          "MR#{n/16}#{(n%16).to_s.rjust(2, '0')}"
        when /^X(\d+)/i
          "R#{$1}"
        when /^Y(\d+)/i
          "R#{$1.to_i + 500}"
        when /^D/i
          device.gsub(/^D+/i, "DM")
        when /^K\d+([A-Z]+.+)/i
          return conv_dev $1
        when /^K\d+$/i
          device.gsub(/^K+/i, "#")
        when /^H(.+)/
          "$#{$1}"
        else
          device
        end
      end

  end


end
