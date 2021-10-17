# ci_md-to-pdf
markdownからPDFを出力する取り組み．  
CSSなどのスタイルやレイアウトは，授業資料とか技術系のドキュメントに使えることを目指す．  
大量のドキュメントを前提とし，GitHub Actionsで，1ドキュメント1PDFに変換したい．  

目指している[出力PDFファイル](./Goal_01_Doc.pdf)．  
日付のヘッダーやページ番号のフッターの再現が重要である．  
[Markdown PDF - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)で生成した．

まずは，[markdownディレクトリの中身](./markdown)を変換する．

`google-chrome-beta_95.0.4638.49-1_amd64.deb` は，[UbuntuUpdates - Package "google-chrome-beta" (stable )](https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-beta)からダウンロードしたものを置いています．
