FROM node:12

WORKDIR /tmp

RUN apt-get update && apt-get install git 
RUN git clone https://github.com/yzane/vscode-markdown-pdf.git

WORKDIR /tmp/vscode-markdown-pdf
RUN npm --global install npm@latest
RUN npm --global install
