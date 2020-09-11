# Ladder Converter

The Ladder converter converts a PLC ladder program to another maker. Our first step is to convert MITSUBISHI PLCs to Keyence PLCs.  
(MITSUBISHI FX series to Keyence KV Nano series)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ladder_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ladder_converter

## Usage

1. Export a mnemonic CSV file of MITSUBISHI PLC by GX Works  
  (Now we trying FX series only.)
2. Execute below ruby code. It generates a mnemonic file for Keyence PLC located you specified to dst_path.

```
    require 'ladder_converter'
    include LadderConverter
    src_path = "path_to_mitsubishi_csv_file ..."
    dst_path = "path_to_store_keyence_mnm_file ..."
    @converter = Mel2Kv.new src:src_path, dst:dst_path
    @converter.save
```

3. Import the mnemonic file to KV STUDIO project.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ito-soft-design/ladder_converter.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

