FROM kalilinux/kali-linux-docker
RUN apt-get update && apt-get install \
  bundler \
  hashcat \
  hashcat-utils \
  hydra \
  john \
  nginx \
  oclhashcat \
  vim \
  -y

COPY password-cracking /root/password-cracking
RUN cd /root/password-cracking/estimator && bundle install

