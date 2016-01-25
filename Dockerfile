FROM phusion/passenger-ruby18:0.9.9

RUN apt-get update && apt-get install wget

RUN wget https://github.com/makandra/rails/raw/2-3-lts/dist/railslts.tar.gz && tar -xzvf railslts.tar.gz

WORKDIR /railslts

RUN ./install

WORKDIR /

RUN rm -rf railslts* && gem list

