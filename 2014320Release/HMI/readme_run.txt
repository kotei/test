ナビアプリを動く：

runnavigadget.sh	360p 起動スクリプト
runnavi.sh		720p 起動スクリプト

HMI配置とnavicore配置を完了した後、下記方法でナビアプリを起動する。	

① 上記全てのファイルをシステムの親ディレクトリにコピーする。

② スクリプト権限を修正する
   chmod 777 /runnavigadget.sh  コマンドを入力する(360pナビ起動スクリプト権限を修正する)
   chmod 777 /runnavi.sh コマンドを入力する(720pナビ起動スクリプト権限を修正する)
 
③ スクリプトコマンドを入力してアプリを起動する
   360pナビを起動する：/runnavigadget.sh 
   720pナビを起動する：/runnavi.sh

注：ナビHMIとWebViewの相対位置の測定方法：
   /apps/navigation.testDev_navigation_6f060a14/native/settingsファイルを修正する
   var HMI_VIEW_RECT = {	
	position: 'absolute',
	left: '0px',
	top: '37px',
	width: '1280px',
	height: '594px'	
	};
   top属性を修正すると、720p HTMLをトップに設定できる
   