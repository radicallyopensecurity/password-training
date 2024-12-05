FROM kalilinux/kali-last-release

ARG TARGETARCH
RUN echo "Detected target architecture is ${TARGETARCH}"

RUN apt-get update && apt-get install \
  # apache2 \
  ruby \
  bundler \
  curl \
  hashcat \
  hashcat-utils \
  # hydra \
  john \
  # php \
  # vim \
  wordlists \
  -y


## commented out since rainbowcrack examples are unmaintained for now
# ARG buildpackages="git build-essential openssl libssl-dev"

# # rcrack has not build a package for arm64, so if we are on arm64, then build it ourselves
# # Install build packages if on arm64
# RUN if [ "$TARGETARCH" = "arm64" ]; then \
#       apt-get update && \
#       apt-get install ${buildpackages} -y; \
#     fi

# # Clone the repository and checkout the specific commit
# RUN if [ "$TARGETARCH" = "arm64" ]; then \
#       git clone https://github.com/bakeromso/RainbowCrack-NG.git /root/password-cracking-resources/RainbowCrack-NG && \
#       cd /root/password-cracking-resources/RainbowCrack-NG && \
#       git checkout 7e5e3465c6cbcbb3e79fdff86d71e0aaa771cb2f; \
#     fi

# # Build and install the software
# RUN if [ "$TARGETARCH" = "arm64" ]; then \
#       cd /root/password-cracking-resources/RainbowCrack-NG/src && \
#       make install; \
#     fi

# # Install rainbowcrack from the repository for non-arm64 architectures
# RUN if [ "$TARGETARCH" != "arm64" ]; then \
#       apt-get update && \
#       apt-get install rainbowcrack -y; \
#     fi

# Copy only necessary files (skip unmaintained examples)
COPY ./estimator /root/password-cracking-resources/estimator
COPY ./generator /root/password-cracking-resources/generator
COPY ./wordlists /root/password-cracking-resources/wordlists
COPY ./welcome.sh /etc/profile.d/welcome.sh
RUN touch ~/.hushlogin

RUN gzip -d /usr/share/wordlists/rockyou.txt.gz -c > /root/rockyou.txt
RUN gzip -d /root/password-cracking-resources/wordlists/dutch.txt.gz -c > /root/dutch.txt
RUN cd /root/password-cracking-resources/estimator && bundle update --bundler && bundle install
RUN cd /root/password-cracking-resources/generator && bundle update --bundler && bundle install
RUN PERL_MM_USE_DEFAULT=1 cpan install Crypt::ScryptKDF

WORKDIR /root/

## commented out because online example is unmaintained
# RUN cp -R /root/password-cracking-resources/online/web/* /var/www/html/ && chown -R www-data:www-data /var/www/html/
# RUN cp /root/password-cracking-resources/online/vhost.conf /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /root/password-cracking-resources/estimator/run.sh /root/estimator
RUN ln -s /root/password-cracking-resources/generator/run.sh /root/generator

## commented out because rainbowtables example is unmaintained
# ADD https://github.com/bakeromso/password-training/ /usr/share/rainbowtables/lm_alpha-numeric#1-7_1_3800x33554432_0.rt
# RUN cd /root/password-cracking-resources/memory && make

# Remove build packages and clean up
RUN if [ "$TARGETARCH" = "arm64" ]; then \
      apt-get remove ${buildpackages} -y && \
      apt-mark manual sudo && \
      apt-get autoremove -y; \
    fi
