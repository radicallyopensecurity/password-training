FROM kalilinux/kali-last-release
RUN apt-get update && apt-get install \
  apache2 \
  bundler \
  curl \
  hashcat \
  hashcat-utils \
  hydra \
  john \
  php \
  rainbowcrack \
  vim \
  wordlists \
  gcc \
  make \
  -y

COPY password-cracking /root/password-cracking
RUN gzip -d /usr/share/wordlists/rockyou.txt.gz
RUN gzip -d /root/password-cracking/wordlists/dutch.txt.gz -c > /usr/share/wordlists/dutch.txt
# RUN PERL_MM_USE_DEFAULT=1 cpan install Crypt::ScryptKDF
# RUN gem install highline -v '1.7.8'
# RUN gem install humanize -v '1.1.2'
# RUN gem install terminal-table -v '1.6.0'
# RUN gem install bundler:1.12.5
# RUN gem install bcrypt -v '3.1.11'
# RUN gem install smbhash -v '1.0.2'
RUN cd /root/password-cracking/estimator && bundle update --bundler && bundle install
RUN cd /root/password-cracking/generator && bundle update --bundler && bundle install

RUN cp -R /root/password-cracking/online/web/* /var/www/html/ && chown -R www-data:www-data /var/www/html/
RUN cp /root/password-cracking/online/vhost.conf /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /root/password-cracking/estimator/run.sh estimator
RUN ln -s /root/password-cracking/generator/run.sh generator

#RUN mkdir /usr/share/rainbowtables
#ADD https://www.radicallyopensecurity.com/rainbow/lm_alpha-numeric.xz /usr/share/rainbowtables/
#RUN unxz /usr/share/rainbowtables/lm_alpha-numeric.xz
#RUN mv /usr/share/rainbowtables/lm_alpha-numeric /usr/share/rainbowtables/lm_alpha-numeric#1-7_1_3800x33554432_0.rt
#RUN cd /root/password-cracking/memory && make