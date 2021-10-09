CC=
build:
	docker build . -t i13302/markdown-to-pdf
run:
	-docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf $(CC) markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf
	-docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf $(CC) markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.pdf --pdf-engine=lualatex -V documentclass=ltjsarticle
	-docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf $(CC) markdown/02_Doc.md -o 02_Doc.pdf --pdf-engine=lualatex -V documentclass=ltjsarticle

clean:
	-rm -f 01_Doc_en.pdf 01_Doc.pdf 02_Doc.pdf 
