# Ladder Converter

ラダーコンバーターはPLCのラダーを他メーカーのラダーに変換します。  
最初のステップとして三菱電機製のPLCからキーエンス製のPLCのラダーに変換することを目指しています。  
具体的にはFXシリーズからKV Nanoシリーズへの変換を試みています。

## Installation

Gemfileを使用している場合はGemfileに下の行を追加します。

```ruby
gem 'ladder_converter'
```

そしてbundleコマンドを実行します。

    $ bundle

または、gemコマンドでinstallします。

    $ gem install ladder_converter

## 使い方

### コマンドとして使用する場合

1. 三菱電機製のPLCプロジェクトをCSVファイルに書き出します。  
  GX Works2で該当ラダーブログラムを表示し、編集メニューからCSVファイルへ書き込みを選択しCSVファイルを書き出せます。 (^1)
  
2. ターミナル (^2) を開きます、下の様にladder_converterに 1 で書き出したCSVファイルを指定し、次に書き出すKeyenceのニーモニックファイルの保存先を指定し実行すると変換されます。

```
    $ ladder_converter source_file target_file
```

3. KV STUDIO で 2 で生成したファイルを読み込みます。  
  ファイルメニューからニーモニックリスト > 読出 を選択し2で保存したファイルを選択するとプロジェクトに取り込まれます。  
  Mainという名称で取り込まれますが、同名のプログラムが既にある場合は取り込まれません。元のMainプログラムを別の名称に変更するか可能なら削除してから行ってください。

### Rubyスクリプトで変換する場合

1. 三菱電機製のPLCプロジェクトをCSVファイルに書き出します。  
  GX Works2で該当ラダーブログラムを表示し、編集メニューからCSVファイルへ書き込みを選択しCSVファイルを書き出せます。(^1)  

2. 下のコードを記述すると変換できます。  
  src_pathには 1 で書き出したCSVファイルを指定します。dst_pathには書き出しすKeyenceのニーモニックファイルの保存先を指定します。
  
```
    require 'ladder_converter'
    include LadderConverter

    src_path = "path_to_mitsubishi_csv_file ..."
    dst_path = "path_to_store_keyence_mnm_file ..."
    converter = Mel2Kv.new src:src_path, dst:dst_path
    converter.save
```

3. KV STUDIO で 2 で生成したファイルを読み込みます。  
  ファイルメニューからニーモニックリスト > 読出 を選択し2で保存したファイルを選択するとプロジェクトに取り込まれます。  
  Mainという名称で取り込まれますが、同名のプログラムが既にある場合は取り込まれません。元のMainプログラムを別の名称に変更するか可能なら削除してから行ってください。

## 進捗状況

現在FX2プロジェクトからKV Nanoプロジェクトへの変換を試みています。  
下のリンクにある、テストで用いたGX Works2プロジェクに含まれている基本的なラダーのみ変換可能です。  
この中に含まれない命令が含まれている場合は変換できません。  

https://github.com/ito-soft-design/ladder_converter/blob/master/test/files/src/FX2N.gxw

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ito-soft-design/ladder_converter.


## ライセンス

[MIT License](http://opensource.org/licenses/MIT)


^1: ラベルを使わずラダーのみのプロジェクトの場合に書き出せます。  
^2: Windowsの場合はコマンドプロンプトまたはWindows PowerShellを起動します。  
