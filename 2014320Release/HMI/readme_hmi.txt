HMI配置:

install.sh 		スクリプトファイル、ナビアプリをインストールし、ナビ環境を設定する
navigation.bar 		720p HTML5インストールファイル
MiniNavi.bar		360p HTML5インストールファイル
display			解像度修正に不可欠のファイル
480p.sh			800*480の実行スクリプト
720p.sh			1280*720の実行スクリプト	

① 上記全てのファイルをシステムの親ディレクトリにコピーする。

② システム解像度を1280*720に変更し、解像度が既に1280*720の場合、直接に③へ飛ばす
   端末と接続した後、chmod 777 /720p.sh を入力し、スクリプト権限を変更する
   /720p.sh を入力し、スクリプトを実行する
   端末を再起動する

③ インストールスクリプト権限を変更する
   chmod 777 /install.sh コマンドを入力する
 
④ インストールナビアプリ720p HTMLアプリ
   /scripts/bar-install  /navigation.barコマンドを入力する
   注：既にHTML5アプリをインストールした場合、まずナビアプリをアンインストールする必要がある/scripts/bar-uninstall navigationコマンドを入力する

⑤ ナビアプリ360p HTMLアプリをインストールする
   /scripts/bar-install  /MiniNavi.barコマンドを入力する
   注：既にHTML5アプリをインストールした場合、まずナビアプリをアンインストールする必要がある。/scripts/bar-uninstall mininavi　コマンドを入力する
