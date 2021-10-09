#!/bin/bash
bash build.sh && docker run --name mtp i13302/markdown-to-pdf python3 main.py && docker cp mtp:WORK/01_Doc.pdf . && docker rm mtp
