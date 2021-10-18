# ci_md-to-pdf
markdownからPDFを出力する取り組み．  
CSSなどのスタイルやレイアウトは，授業資料とか技術系のドキュメントに使えることを目指す．  
大量のドキュメントを前提とし，GitHub Actionsで，1ドキュメント1PDFに変換したい．  

目指している[出力PDFファイル](./Goal_01_Doc.pdf)．  
日付のヘッダーやページ番号のフッターの再現が重要である．  
[Markdown PDF - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)で生成した．

現状の生成物は，各Actionsの実行結果を確認のこと．

## Status
- [x] MarkdownからCSSを維持したHTMLファイルの生成
- [x] HTMLファイルからPDFの生成
- [x] ヘッダーやフッターを持つPDFの生成
- [x] 一連の実行を1手順での自動化
- [x] 大量のドキュメントへの対応
