NameVirtualHost ihub.phillbaker.com:80

<VirtualHost ihub.phillbaker.com:80>
     ServerAdmin webmaster@dummy-host.example.com
     DocumentRoot "/var/www/ihub.phillbaker.com/current/public"
     ServerName ihub.phillbaker.com
</VirtualHost>
