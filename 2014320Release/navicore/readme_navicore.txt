navicore配置:

navigation.zip 		ナビapp及びデータディレクトリ

① 上記全てのファイルをシステムの親ディレクトリにコピーする。

② ナビappをインストールする
   /install.sh /navigation.zip コマンドを入力する

③ データをDataパスにコピーする
   上記④を完成した後、システム親パスで/koteinavidataが作成され、データファイルを/koteinavidata/Dataにコピーする。データコピーが完了した後、Data構造が以下になる：
   cd /koteinavidata/Dataを入力
   lsを入力
   以下のディレクトリ構造が表示される
   Config               GUD                  Locator              Map                  POI                  qt.ini
   Font                 Hdr                  MD                   MeshCodeTable.dat    VICS