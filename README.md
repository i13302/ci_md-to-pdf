# ci_md-to-pdf
markdownからPDFを出力する取り組み．  
CSSなどのスタイルやレイアウトは，授業資料とか技術系のドキュメントなど，自由に組み込める．  
大量のドキュメントを前提とし，GitHub Actionsで，1ドキュメント1PDFに変換する．  

日付のヘッダーやページ番号のフッターが実現できる．  

現状の生成物は，各Actionsの実行結果を確認のこと．  

## Status
- [x] MarkdownからCSSを維持したHTMLファイルの生成
- [x] HTMLファイルからPDFの生成
- [x] ヘッダーやフッターを持つPDFの生成
- [x] 一連の実行を1手順での自動化
- [x] 大量のドキュメントへの対応

## Usage
### Get Image
#### Docker Pull

[Package printout](https://github.com/i13302/ci_md-to-pdf/pkgs/container/printout)

```:shell
docker pull ghcr.io/i13302/printout
```

#### Local Build
```:shell
make build
```

Builded Image `i13302/printout`. 

### Build Text
```:shell
make setup
```

The markdown text into `work/markdown` dir and css into `work/css` dir.  

```:shell
make run
```

### Product PDF
markdown is builded to PDF file in `work/pdf` dir.

### Clean up builded files
remove `work/html` and `work/pdf`.

```:shell
make clean
```

### Test
This is builded in `test` dir.

#### Build Text
```Sample:shell
make test_run
```

### Clean up
```Sample:shell
make test_clean
```

## License
[MIT License](./LICENSE).
