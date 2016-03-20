FROM phusion/passenger-ruby18:0.9.9

RUN apt-get update && \
    apt-get -y install zlib1g-dev \
                       libxml2-dev \
                       libmysqlclient-dev \
                       libxslt1-dev \
                       libpq-dev \
                       libsqlite3-dev \
                       zip

RUN git clone -b 2-3-lts https://github.com/makandra/rails.git rails-2-3-lts

WORKDIR /rails-2-3-lts

RUN bundle install && \
    rake railslts:gems:build

RUN gem install --no-ri --no-rdoc pkg/activesupport-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/activerecord-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/actionpack-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/actionmailer-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/activeresource-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/railties-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/railslts-version-2.3.*.gem && \
    gem install --no-ri --no-rdoc pkg/rails-2.3.*.gem && \
    gem uninstall railslts-version -v 2.3.18.12

WORKDIR /

RUN rm -rf rails-2-3-lts* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    gem list
