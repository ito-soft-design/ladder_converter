require 'csv'
require 'kv_code'

module LadderConverter
class Mel2Kv

  attr_reader :codes
  attr_reader :converted
  attr_reader :src, :dst
  attr_reader :logging_file

  attr_reader :ignore_unknown

  def initialize options={}
    @src = options[:src]
    @dst = options[:dst]
    @logging_file = options[:logging_file]
    @ignore_unknown = options[:ignore_unknown]
    @codes = nil
  end

  def load
    return false unless File.exist? @src
    return true if @codes

    begin
      logfile = File.open(logging_file, "w") rescue nil

      @codes = []
      has_end = false
      CSV.open(@src, "rb:BOM|UTF-16:UTF-8", headers:true, skip_lines:Regexp.new(/^[^\t]+$|PC情報:/), col_sep:"\t").each_with_index do |row, i|
        begin
          mnemonic = row["命令"]
          device = row["I/O(デバイス)"]
          case mnemonic
          when ""
            @codes.last.add_device device
          when 'END', 'FEND'
            unless has_end
              @codes << KvCode.new(mnemonic, [device])
              has_end = true
            end
          else
            @codes << KvCode.new(mnemonic, [device])
          end
        rescue UnknownCodeError => e
          mes = "[WARN] SKIPPED! : line #{i+(3+1)} : #{e}"
          STDERR.puts mes
          logfile.puts mes if logfile
          raise unless ignore_unknown
        end
      end
    ensure
      logfile.close if logfile
    end
  end

  def convert
    load
    @converted = <<EOS
DEVICE:132
;MODULE:Main
;MODULE_TYPE:0
EOS
    # collect subrouten labels
    sb_labels = codes.select{|c| c.mnemonic == "CALL"}.map{|c| c.devices.first}
    # replace mnemonic LABLE to SBN if it's for subroutin.
    codes.select{|c| c.mnemonic == "LABEL" && sb_labels.include?(c.device)}.each{|c| c.becone_subroutin_label }

    # add kv codes string
    @converted += codes.map(&:to_s).join("\n")
    @converted += "\nENDH\n"
  end

  def save
    return unless dst
    convert
    File.write dst, converted
  end


  private

  def kv_mnemonic mnemonic
    mnemonic
  end

end
end
