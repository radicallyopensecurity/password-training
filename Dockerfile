FROM kalilinux/kali-linux-docker
RUN apt-get update && apt-get install \
  apache2 \
  bundler \
  curl \
  hashcat \
  hashcat-utils \
  hydra \
  john \
  oclhashcat \
  php \
  rainbowcrack \
  vim \
  wordlists \
  -y

COPY password-cracking /root/password-cracking
RUN gzip -d /usr/share/wordlists/rockyou.txt.gz
RUN gzip -d /root/password-cracking/wordlists/dutch.txt.gz -c > /usr/share/wordlists/dutch.txt
RUN cd /root/password-cracking/estimator && bundle install
RUN cd /root/password-cracking/generator && bundle install
RUN PERL_MM_USE_DEFAULT=1 cpan install Crypt::ScryptKDF
RUN cp -R /root/password-cracking/online/web/* /var/www/html/ && chown -R www-data:www-data /var/www/html/
RUN cp /root/password-cracking/online/vhost.conf /etc/apache2/sites-enabled/000-default.conf
RUN mkdir /usr/share/rainbowtables
ADD https://www.radicallyopensecurity.com/rainbow/lm_alpha-numeric.xz /usr/share/rainbowtables/
RUN unxz /usr/share/rainbowtables/lm_alpha-numeric.xz
RUN mv /usr/share/rainbowtables/lm_alpha-numeric /usr/share/rainbowtables/lm_alpha-numeric#1-7_1_3800x33554432_0.rt