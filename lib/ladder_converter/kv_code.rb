require 'plc_code'

module LadderConverter


  class KvCode < PlcCode

    def initialize mnemonic, devices
      super
      case self.mnemonic
      when 'LABEL'
        @devices = [own_device(mnemonic)]
      end
    end
      
    def becone_subroutin_label
      @mnemonic = 'SBN'
    end

    def to_s
      return mnemonic if devices.empty?
      ([mnemonic] + devices).join(" ")
    end

    private

      def own_mnemonic mnemonic
        mnemonic.upcase!
        case mnemonic

          
        when 'INC', 'DEC'
          mnemonic
        when /^(ADD|SUB|MUL|DIV)$/
          {
            "ADD"   => "CAL+",
            "SUB"   => "CAL-",
            "MUL"   => "CAL*",
            "DIV"   => "CAL/",
          }[mnemonic]

        when /^(ADD|SUB|MUL|DIV|INC|DEC)P$/, /^@(ADD|SUB|MUL|DIV|INC|DEC)$/
          "@#{own_mnemonic($1)}"
        when /^D((ADD|SUB|MUL|DIV|INC|DEC)P)$/
          "#{own_mnemonic($1)}.D"

        when 'MPS', 'MRD', 'MPP'
          mnemonic


        when /^D(.+)/
          "#{own_mnemonic($1)}.D"

        when 'LDP', 'ORP'
          mnemonic
        when 'ANDP'
          'ANP'
        when /(.+)P$/
          "@#{own_mnemonic($1)}"

        when "PLF"
          "DIFD"
        when 'ANDF'
          'ANF'
        when /(.+)F$/
          "#{own_mnemonic($1)}F"

        when /^(LD|AND|OR)D([=<>]+)/
          "#{$1}#{$2}.D"

        when /^P(\d+)/
          'LABEL'

        when 'LD', 'OUT', 'END', 'AND', 'OR', 'SET',
             'MOV',
             'LD=', 'AND=', 'OR=',
             'LD<>', 'AND<>', 'OR<>',
             'LD<', 'AND<', 'OR<',
             'LD>', 'AND>', 'OR>',
             'LD<=', 'AND<=', 'OR<=',
             'LD>=', 'AND>=', 'OR>=',
             'CJ', 
             'CALL'
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
          
            "WAND"  => "CAL&",
            "WOR"   => "CAL|",

            'SRET'  => 'RET',

            "FEND"  => "END",

          }[mnemonic]
          if n
            n
          else
            raise UnknownCodeError, "Unknown mnemonic \"#{mnemonic}\"."
          end
        end
      end

      def own_device device
        begin
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
          when /^P(\d+)/
            "##{$1}"
          else
            device
          end
        rescue
          raise UnknownCodeError, "Unknown device \"#{device}\"."
        end
      end

  end


end
