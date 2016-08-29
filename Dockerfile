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
RUN cp -R /root/password-cracking/online/web/* /var/www/html/ && chown -R www-data:www-data /var/www/html/
RUN cp /root/password-cracking/online/vhost.conf /etc/apache2/sites-enabled/000-default.conf