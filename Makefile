build:
	docker build . -t i13302/markdown-to-pdf
run:
	-docker run --name mtp i13302/markdown-to-pdf markdown/01_Doc.md -o 01_Doc.pdf --pdf-engine=xelatex && docker cp mtp:/data/01_Doc.pdf . 
	docker rm mtp
	-docker run --name mtp i13302/markdown-to-pdf markdown/02_Doc.md -o 02_Doc.pdf && docker cp mtp:/data/02_Doc.pdf . 
	docker rm mtp
	
clean:
	-docker rm mtp
	-rm 01_Doc.pdf 02_Doc.pdf 
