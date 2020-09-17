module LadderConverter

  class PlcCode

    attr_reader :mnemonic
    attr_reader :devices


    def initialize mnemonic, devices
      @mnemonic = own_mnemonic mnemonic
      @devices = devices.map{|d| own_device d}.select{|d| d && d.length != 0}
    end

    def add_device device
      @devices << own_device(device)
    end

    def device
      devices.first
    end

    private

      def own_mnemonic mnemonic
        mnemonic
      end

      def own_device device
        device
      end

  end

  class UnknownCodeError < StandardError
  end

end
