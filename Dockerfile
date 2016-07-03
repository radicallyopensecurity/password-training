FROM kalilinux/kali-linux-docker
RUN apt-get update && apt-get -y install \
  john \
  hashcat \
  oclhashcat \
  hashcat-utils \
  bundler

COPY password-cracking /root/password-cracking
RUN cd /root/password-cracking/estimator && bundle install
