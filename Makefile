build:
	docker build . -t i13302/markdown-to-pdf
run:
	-docker run --name mtp i13302/markdown-to-pdf markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf --pdf-engine=wkhtmltopdf
	-docker cp mtp:/data/01_Doc_en.pdf . 
	docker rm mtp
	-docker run --name mtp i13302/markdown-to-pdf markdown/01_Doc_en.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc_en.pdf --pdf-engine=xelatex
	-docker cp mtp:/data/01_Doc_en.pdf . 
	docker rm mtp
	-docker run --name mtp i13302/markdown-to-pdf markdown/01_Doc.md -c .github/style/markdown.css -c .github/style/markdown-pdf.css -o 01_Doc.pdf --pdf-engine=xelatex
	-docker cp mtp:/data/01_Doc.pdf . 
	docker rm mtp
	-docker run --name mtp i13302/markdown-to-pdf markdown/02_Doc.md -o 02_Doc.pdf --pdf-engine=lualatex
	-docker cp mtp:/data/02_Doc.pdf . 
	docker rm mtp
	
clean:
	-docker rm mtp
	-rm 01_Doc_en.pdf 01_Doc.pdf 02_Doc.pdf 
