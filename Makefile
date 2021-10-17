CC=
CTN=pandoc/latex
build:
	docker build . -t $(CTN)
run:
	-docker run --rm --volume "$(shell pwd):/data" $(CTN) $(CC) -f markdown -t html --self-contained markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -t html -o 01_Doc_en.html
	-docker run --rm --volume "$(shell pwd):/data" $(CTN) $(CC) -f markdown -t html --self-contained markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.html --pdf-engine=lualatex -V documentclass=ltjsarticle
clean:
	-rm -f 01_Doc_en.pdf 01_Doc.pdf 02_Doc.pdf 
	-rm -f 01_Doc_en.html 01_Doc.html 02_Doc.html
