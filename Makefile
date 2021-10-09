build:
	docker build . -t i13302/markdown-to-pdf
run:
	-docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf pandoc markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -t html -o 01_Doc_en.pdf
	-docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf pandoc markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.pdf --pdf-engine=lualatex -V documentclass=ltjsarticle
	-docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf pandoc  markdown/02_Doc.md -o 02_Doc.pdf --pdf-engine=lualatex -V documentclass=ltjsarticle

clean:
	-docker rm mtp
	-rm -f 01_Doc_en.pdf 01_Doc.pdf 02_Doc.pdf 



# docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf --pdf-engine=lualatex
# docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.pdf
# docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf markdown/02_Doc.md -o 02_Doc.pdf

#docker run --rm --volume "$(pwd):/data" i13302/markdown-to-pdf markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf --pdf-engine=lualatex

# docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf pandoc markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf --pdf-engine=lualatex
# docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf pandoc markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.pdf
# docker run --rm --volume "$(shell pwd):/data" i13302/markdown-to-pdf pandoc  markdown/02_Doc.md -o 02_Doc.pdf

# -docker run --name mtp i13302/markdown-to-pdf markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf
# -docker cp mtp:/data/01_Doc_en.pdf . 
# docker rm mtp
# -docker run --name mtp i13302/markdown-to-pdf markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.pdf
# -docker cp mtp:01_Doc.pdf . 
# docker rm mtp
# -docker run --name mtp i13302/markdown-to-pdf markdown/02_Doc.md -o 02_Doc.pdf --pdf-engine=lualatex
# -docker cp mtp:02_Doc.pdf . 
# docker rm mtp
