#!/bin/bash
docker run -t -i --mount type=bind,source=./password-cracking/,target=/root/password-cracking training /bin/bash