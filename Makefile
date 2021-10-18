CC=
CTN1=pandoc/latex
CTN2=i13302/printout
TZ=-e TZ=Asia/Tokyo

WORKDIR=work
CSSDIR=css
HTMLDIR=html
MDDIR=markdown
PDFDIR=pdf

setup:
	mkdir -p ${WORKDIR}/${CSSDIR} ${WORKDIR}/${HTMLDIR} ${WORKDIR}/${MDDIR} ${WORKDIR}/${PDFDIR}

build:
	docker build . -t $(CTN2)

test:
	docker run --rm --volume "$(shell pwd)/${WORKDIR}:/data" $(CTN1) $(CC) -f markdown --self-contained ${MDDIR}/01_Doc_en.md -c ${CSSDIR}/markdown.css -c ${CSSDIR}/markdown-pdf.css -o ${HTMLDIR}/01_Doc_en.html && docker run --rm $(TZ) --volume "$(shell pwd)/${WORKDIR}:/data" $(CTN2) $(CC) "${HTMLDIR}/01_Doc_en.html ${PDFDIR}/01_Doc_en.pdf"
	docker run --rm --volume "$(shell pwd)/${WORKDIR}:/data" $(CTN1) $(CC) -f markdown --self-contained ${MDDIR}/01_Doc.md -c ${CSSDIR}/markdown.css -c ${CSSDIR}/markdown-pdf.css -o ${HTMLDIR}/01_Doc.html && docker run --rm $(TZ) --volume "$(shell pwd)/${WORKDIR}:/data" $(CTN2) $(CC) "${HTMLDIR}/01_Doc.html ${PDFDIR}/01_Doc.pdf"


clean:
	-rm -f ${WORKDIR}/${HTMLDIR}/*.html ${WORKDIR}/${PDFDIR}/*.pdf
