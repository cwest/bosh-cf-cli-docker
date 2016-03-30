FROM ruby:2.3.0-alpine

# Install alternative shells.
RUN apk update \
  && apk add bash zsh

# Install system dependencies.
RUN apk update \
  && apk add build-base sqlite-dev libxml2-dev libxslt-dev

# Install glibc compatibility layer.
RUN apk --no-cache add ca-certificates \
  && wget -q -O /etc/apk/keys/andyshinn.rsa.pub https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/andyshinn.rsa.pub \
  && wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk \
  && apk add glibc-2.23-r1.apk


# Install BOSH CLI.
RUN gem install nokogiri --no-ri --no-rdoc -- --use-system-libraries \
  && gem install bosh_cli bosh_cli_plugin_micro --no-ri --no-rdoc

# Install Spiff (BOSH manifest helper).
RUN cd /usr/local/bin \
  && curl -L -o spiff.zip "https://github.com/cloudfoundry-incubator/spiff/releases/download/v1.0.7/spiff_linux_amd64.zip" \
  && unzip spiff.zip && rm -f spiff.zip

# Install Cloud Foundry CLI.
RUN cd /usr/local/bin \
  && curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.16.1&source=github-rel" | tar -zx

CMD [ "bash" ]
