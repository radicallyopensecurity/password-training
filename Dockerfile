FROM kalilinux/kali-last-release

ARG TARGETARCH
RUN echo "Detected target architecture is ${TARGETARCH}"

RUN apt-get update && apt-get install \
  apache2 \
  bundler \
  curl \
  hashcat \
  hashcat-utils \
  hydra \
  john \
  php \
  vim \
  wordlists \
  gcc \
  make \
  -y

# rcrack has not build a package for arm64, so if we are on arm64, then build it ourselves
RUN if [ "$TARGETARCH" = "arm64" ]; then \
  apt-get install \
  git \
  build-essential \
  openssl \
  libssl-dev \
  -y; \
  git clone https://github.com/bakeromso/RainbowCrack-NG.git /RainbowCrack-NG && \
  cd /RainbowCrack-NG && \
  git checkout 7e5e3465c6cbcbb3e79fdff86d71e0aaa771cb2f && \
  cd /RainbowCrack-NG/src &&\
  make install; \
  # If we're building for anything else but arm64, just install rainbowcrack from the kali repos
  else \
  apt-get install rainbowcrack -y;\
  fi

COPY password-cracking /root/password-cracking
RUN gzip -d /usr/share/wordlists/rockyou.txt.gz
RUN gzip -d /root/password-cracking/wordlists/dutch.txt.gz -c > /usr/share/wordlists/dutch.txt
RUN cd /root/password-cracking/estimator && bundle update --bundler && bundle install
RUN cd /root/password-cracking/generator && bundle update --bundler && bundle install
RUN PERL_MM_USE_DEFAULT=1 cpan install Crypt::ScryptKDF

RUN cp -R /root/password-cracking/online/web/* /var/www/html/ && chown -R www-data:www-data /var/www/html/
RUN cp /root/password-cracking/online/vhost.conf /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /root/password-cracking/estimator/run.sh estimator
RUN ln -s /root/password-cracking/generator/run.sh generator

RUN mkdir /usr/share/rainbowtables
#ADD https://www.radicallyopensecurity.com/rainbow/lm_alpha-numeric.xz /usr/share/rainbowtables/
#RUN unxz /usr/share/rainbowtables/lm_alpha-numeric.xz
#RUN mv /usr/share/rainbowtables/lm_alpha-numeric /usr/share/rainbowtables/lm_alpha-numeric#1-7_1_3800x33554432_0.rt
#RUN cd /root/password-cracking/memory && make