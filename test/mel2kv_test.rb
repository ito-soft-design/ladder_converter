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
LD MR010
AND MR011
OUT MR6208
LD MR010
ANB MR011
OUT MR6209
LD MR010
OR MR011
OUT MR6210
LD MR010
ORB MR011
OUT MR6211
LD MR010
OR MR011
LD MR012
OR MR013
ANL
OUT MR6212
LD MR010
AND MR011
LD MR012
AND MR013
ORL
OUT MR6213
LD MR604
DIFU MR6214
LD MR604
DIFD MR6215
LD MR605
SET MR6300
LD MR606
RES MR6300
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
