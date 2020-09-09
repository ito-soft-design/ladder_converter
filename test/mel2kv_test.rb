require 'test/unit'
require 'mel2kv'
require 'fileutils'

include LadderConvertor
include FileUtils

$dir = File.dirname(File.expand_path(__FILE__))
$root = File.dirname($dir)

class TestMel2Kv < Test::Unit::TestCase

  setup do
    src = File.join($dir, 'files', 'src', 'MAIN.csv')
    dst = File.join($dir, 'files', 'dst', 'MAIN.mnm')
    @conv = Mel2Kv.new src:src, dst:dst
  end

  # It should load a source file successfully, and it has a three codes.
  def test_load
    assert @conv.load
  end

  def test_convert
    expected = <<EOS
DEVICE:132
;MODULE:Main
;MODULE_TYPE:0
LD R000
OUT R500
LDB R001
OUT R501
END
ENDH
EOS
    @conv.convert
    assert_equal expected, @conv.converted
  end

  def test_save
    mkdir_p File.dirname(@conv.dst)
    @conv.save
  end

end
