NameVirtualHost mobyle.phillbaker.com:80

<VirtualHost mobyle.phillbaker.com:80>
     ServerAdmin webmaster@dummy-host.example.com
     DocumentRoot "/var/www/mobyle.phillbaker.com/current/public"
     ServerName mobyle.phillbaker.com
</VirtualHost>
