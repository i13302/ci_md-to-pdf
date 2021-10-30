CC=pandoc
CTN1=i13302/pandoc
CTN2=i13302/printout
TZ=-e TZ=Asia/Tokyo

WORKDIR=work
TESTDIR=test

CSSDIR=css
HTMLDIR=html
MDDIR=markdown
PDFDIR=pdf

setup:
	mkdir -p ${WORKDIR}/${CSSDIR} ${WORKDIR}/${HTMLDIR} ${WORKDIR}/${MDDIR} ${WORKDIR}/${PDFDIR}

build:
	cd pandoc   ; docker build . -t $(CTN1)
	cd printout ; docker build . -t $(CTN2)

run:
	perl run.pl --work=${WORKDIR} --markdown=${MDDIR} --html=${HTMLDIR} --css=${CSSDIR} --pdf=${PDFDIR} --mdtohtml=${CTN1} --htmltopdf=${CTN2} --TZ=${TZ}

test_file:
	docker run --rm --volume "$(shell pwd)/${TESTDIR}:/data" $(CTN1) "cd ${MDDIR} && $(CC) -f markdown --self-contained 01_Doc_en.md -c ../${CSSDIR}/markdown.css -c ../${CSSDIR}/markdown-pdf.css -o ../${HTMLDIR}/01_Doc_en.html"
	docker run --rm $(TZ) --volume "$(shell pwd)/${TESTDIR}:/data" $(CTN2) "${HTMLDIR}/01_Doc_en.html ${PDFDIR}/01_Doc_en.pdf"
	
	docker run --rm --volume "$(shell pwd)/${TESTDIR}:/data" $(CTN1) "cd ${MDDIR} && $(CC) -f markdown --self-contained 01_Doc_ja.md -c ../${CSSDIR}/markdown.css -c ../${CSSDIR}/markdown-pdf.css -o ../${HTMLDIR}/01_Doc_ja.html"
	docker run --rm $(TZ) --volume "$(shell pwd)/${TESTDIR}:/data" $(CTN2) "${HTMLDIR}/01_Doc_ja.html ${PDFDIR}/01_Doc_ja.pdf"

test_run:
	perl run.pl --work=${TESTDIR} --markdown=${MDDIR} --html=${HTMLDIR} --css=${CSSDIR} --pdf=${PDFDIR} --mdtohtml=${CTN1} --htmltopdf=${CTN2} --TZ=${TZ}

test_clean:
	-rm -f ${TESTDIR}/${HTMLDIR}/*.html ${TESTDIR}/${PDFDIR}/*.pdf

clean:
	-rm -f ${WORKDIR}/${HTMLDIR}/*.html ${WORKDIR}/${PDFDIR}/*.pdf
