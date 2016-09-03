#!/bin/bash

OUTPUT="deploy.sh"

echo "#!/bin/bash" > $OUTPUT
echo 'echo "Creating Apache vhost config..."' >> $OUTPUT

if [ -f "../vhost.conf" ]; then
  echo "Including Apache configuration..."
  vhost=`cat ../vhost.conf | base64`
  echo -ne "read -d '' vhost << EOC\n$vhost\nEOC\n" >> $OUTPUT
  echo 'echo "$vhost" | base64 -d > /etc/apache2/sites-enabled/000-default.conf' >> $OUTPUT
else
  echo "Did not find expected Apache vhost configuration in ../vhost.conf!"
  exit 1
fi

echo 'echo "Reloading Apache config..."' >> $OUTPUT
echo "service apache2 reload" >> $OUTPUT

echo 'echo "Creating website content..."' >> $OUTPUT
if [ -d "../web" ]; then
  echo "Including website content..."
  tar -zcf content.tar.gz ../web 2> /dev/null
  content=`cat content.tar.gz | base64`
  rm content.tar.gz
  echo -ne "read -d '' content << EOC\n$content\nEOC\n" >> $OUTPUT
  echo 'echo "$content" | base64 -d > content.tar.gz' >> $OUTPUT
  echo 'tar -zxf content.tar.gz 2> /dev/null' >> $OUTPUT
  echo 'cp -R web/* /var/www/html/' >> $OUTPUT
  echo 'chown -R www-data:www-data /var/www/html/' >> $OUTPUT
else
  echo "Did not find expected web content in ../web/!"
  exit 1
fi

echo 'echo "Deployment ready!"' >> $OUTPUT

echo ""
echo "Created deploy script '$OUTPUT'."