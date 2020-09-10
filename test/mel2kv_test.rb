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
LD MR604
OUT MR1208
MPS
AND MR605
OUT MR1209
MRD
AND MR606
OUT MR1210
MPP
AND MR607
OUT MR1211
LDP MR614
OUT MR1302
LDF MR614
OUT MR1303
LD MR614
ANP MR615
OUT MR1304
LD MR614
ANF MR615
OUT MR1305
LD MR614
ORP MR615
OUT MR1306
LD MR614
ORF MR615
OUT MR1307
LD MR708
MOV #0 DM0
CAL+ DM0 #1 DM0
CAL- DM0 #1 DM0
CAL* DM0 #1 DM0
CAL/ DM0 #1 DM0
LD MR708
MOV.D #0 DM0
CAL+.D DM0 #1 DM0
CAL-.D DM0 #1 DM0
CAL*.D DM0 #1 DM0
CAL/.D DM0 #1 DM0
LD= #0 DM0
OR= #0 DM0
AND= #0 DM0
OUT MR1312
LD<> #0 DM0
OR<> #0 DM0
AND<> #0 DM0
OUT MR1313
LD< #0 DM0
OR< #0 DM0
AND< #0 DM0
OUT MR1314
LD> #0 DM0
OR> #0 DM0
AND> #0 DM0
OUT MR1315
LD<= #0 DM0
OR<= #0 DM0
AND<= #0 DM0
OUT MR1400
LD>= #0 DM0
OR>= #0 DM0
AND>= #0 DM0
OUT MR1401
LD=.D #0 DM0
OR=.D #0 DM0
AND=.D #0 DM0
OUT MR1402
LD<>.D #0 DM0
OR<>.D #0 DM0
AND<>.D #0 DM0
OUT MR1403
LD<.D #0 DM0
OR<.D #0 DM0
AND<.D #0 DM0
OUT MR1404
LD>.D #0 DM0
OR>.D #0 DM0
AND>.D #0 DM0
OUT MR1405
LD<=.D #0 DM0
OR<=.D #0 DM0
AND<=.D #0 DM0
OUT MR1406
LD>=.D #0 DM0
OR>=.D #0 DM0
AND>=.D #0 DM0
OUT MR1407
LD MR709
CAL& DM0 $1234 DM0
CAL| DM0 $1234 DM0
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
