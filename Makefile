CC=
CTN1=pandoc/latex
CTN2=i13302/printout
TZ=-e TZ=Asia/Tokyo

build:
	docker build . -t $(CTN2)

run:
	-docker run --rm --volume "$(shell pwd)/work:/data" $(CTN1) $(CC) -f markdown -t html --self-contained markdown/01_Doc_en.md -c css/markdown.css -c css/markdown-pdf.css -t html -o html/01_Doc_en.html && docker run --rm $(TZ) --volume "$(shell pwd)/work:/data" $(CTN2) $(CC) "html/01_Doc_en.html pdf/01_Doc_en.pdf"
	-docker run --rm --volume "$(shell pwd)/work:/data" $(CTN1) $(CC) -f markdown -t html --self-contained markdown/01_Doc.md -c css/markdown.css -c css/markdown-pdf.css -t html -o html/01_Doc.html && docker run --rm $(TZ) --volume "$(shell pwd)/work:/data" $(CTN2) $(CC) "html/01_Doc.html pdf/01_Doc.pdf"


clean:
	-rm -f  work/html/*.html work/pdf/*.pdf
