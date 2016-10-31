#!/bin/bash
echo "Creating Apache vhost config..."
read -d '' vhost << EOC
PFZpcnR1YWxIb3N0ICo6ODA+CiAgICBTZXJ2ZXJBZG1pbiB3ZWJtYXN0ZXJAbG9jYWxob3N0CiAg
ICBEb2N1bWVudFJvb3QgL3Zhci93d3cvaHRtbAogICAgRXJyb3JMb2cgJHtBUEFDSEVfTE9HX0RJ
Un0vZXJyb3IubG9nCiAgICBDdXN0b21Mb2cgJHtBUEFDSEVfTE9HX0RJUn0vYWNjZXNzLmxvZyBj
b21iaW5lZAogICAgPERpcmVjdG9yeSAiL3Zhci93d3cvaHRtbC8iPgogICAgCUFsbG93T3ZlcnJp
ZGUgQWxsCiAgICA8L0RpcmVjdG9yeT4KPC9WaXJ0dWFsSG9zdD4K
EOC
echo "$vhost" | base64 -d > /etc/apache2/sites-enabled/000-default.conf
echo "Reloading Apache config..."
service apache2 reload
echo "Creating website content..."
read -d '' content << EOC
H4sIAOr1ylcAA+1YW2/bNhT2q/0rTgSjTYDNEnUtWtlFMzdN0cbxGm9rsA0FLVGVAt0iUXaMdf99
pC52nGRLHmxnW/g9SKJ4Dkmdi85HzslUbm0ZCoNlGPyOLEMp20jXy3uNFlItUzUsxVLYe4Q002yB
se2FcRQ5xRlAy0mS0Asy8vdyJMt3saDdYs787yVZtM0geKD/dUMzDcVkckjVNF34fxdY+j+IXXLV
S/1083NwB5uVv+/yP2KOX/nfQMz/OjLUFiibX8ptPHH/26+ZyzsAgbfPrgAkSuliv/tlfHo2+VXi
Hx3jiEi/H8C3b3cIpDjP50nmMgHWewB/dF4POrZPo3DA2rZPsDso1Wwa0JAMjlioAS6oT2IaOJgG
SWzLVReXlxsFe5q4i0YTT6tu3uCxChGhfuL2pTTJqVT3MLmseWTP7uCneu1sfHetww7itKBAFynp
S5RcUQm4XH/1tYNrOuyxGffmDOP64/95hqWJ6lmW7QfOsjZYXkyjYLngpjXDYcGaH5OvQXz3sHaZ
5OyRvanMacuViZnNS281gfAnkDAnzJFcv+vj3Ic+PO+qiy5SutHh2+zsCKnzn99djAPj8vjo84/H
vd7QOe+Z8/gyHL2gL96Yztnp+acP3sno8PNw4n14/qpTDtaEGBv2VnhBvw8SdiO2fnj2rBZrLPVl
RrLAuyvovqtWeFAqHNSLZjHq+AlU5oC8cByS514R7v0WS69KibVvXBf3cBASF17ur4S5UXhYP3aq
bgX8/z/FeeBskQA8vP5bhmopvP7rrAyI+r8DrPzf82mZWO7G57in/iuKoTf13zIVjdd/TbFE/d8F
yn/uyy5OM9R9n9JftPeHV92ZfHZxdXGCZCfUhqNhukAj1ej9P3+ATxyr/K82AJwMbHqO+/JfVdCS
/yNT5fmva6bI/13A3hue/jA5H7+FmgZWt3ZN3dvt68Q95BRpydfbDV1v12y93X6XEUwbyrUH50kB
Pp4RrviVsaog7nGtNeL52AZ44lir/7j028bnuC//kX6T/+mqLvb/O8EbthefsK0lHPIg6PDmiO3I
6u2QVL7gO+kjti0CeYYzeT6fl5l7kzZ2PpHLghmQ70YD93tur05HcIZ/OXj+b6/yV7i3/lvm6vwf
WSz/Nc3SRf7vAnZT9stKXhf7IYkSyANK8mWxb2p9XeptDH5GvL50izxKg+PJZAzl6/KkD1w+Wk0d
8MCeZiBfH2D99Jmrn3yUx8djKI/61pVvnlo9tvUEBAQEBAQEBAQEBAT+O/gLxx0F9gAoAAA=
EOC
echo "$content" | base64 -d > content.tar.gz
tar -zxf content.tar.gz 2> /dev/null
cp -R web/* /var/www/html/
chown -R www-data:www-data /var/www/html/
echo "Deployment ready!"
