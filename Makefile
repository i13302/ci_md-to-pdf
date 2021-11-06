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

test_dir:
	docker run --rm --volume "$(shell pwd)/${TESTDIR}:/data" $(CTN1) pandoc ${MDDIR} ${HTMLDIR} ${CSSDIR}

	docker run --rm $(TZ) --volume "$(shell pwd)/${TESTDIR}:/data" $(CTN2) "${HTMLDIR}/01_Doc_en.html ${PDFDIR}/01_Doc_en.pdf"
	

test_run:
	perl run.pl --work=${TESTDIR} --markdown=${MDDIR} --html=${HTMLDIR} --css=${CSSDIR} --pdf=${PDFDIR} --mdtohtml=${CTN1} --htmltopdf=${CTN2} --TZ=${TZ}

test_clean:
	-rm -f ${TESTDIR}/${HTMLDIR}/*.html ${TESTDIR}/${PDFDIR}/*.pdf

clean:
	-rm -f ${WORKDIR}/${HTMLDIR}/*.html ${WORKDIR}/${PDFDIR}/*.pdf
