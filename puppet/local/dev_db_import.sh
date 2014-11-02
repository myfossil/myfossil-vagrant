#!/bin/bash
cd /var/www/myfossil
wp db import /vagrant/sql/wp_myfossil.sql
wp search-replace myfossil.clients.geometeor.com myfossil.local:8080
