{ pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.httpd = {
    enable = true;
    enablePHP = true;
    virtualHosts = {
      "local.partytrackr.com" = let 
        root =  "/home/chris/dev/www/partytrackr";
      in {
        documentRoot = root;
        http2 = false;
        extraConfig = ''
          # php -- BEGIN cPanel-generated handler, do not edit
          # Set the “ea-php81” package as the default “PHP” programming language.
          <IfModule mime_module>
            AddHandler application/x-httpd-ea-php81 .php .php8 .phtml
          </IfModule>
          # php -- END cPanel-generated handler, do not edit

          RewriteEngine On

          # Redirect to public folder if not accessing it directly
          RewriteCond %{REQUEST_URI} !^/public/
          RewriteCond %{REQUEST_URI} !^/api/
          RewriteCond %{REQUEST_URI} !\.(css|js|png|jpg|gif|ico|html|svg)$ [NC]
          RewriteRule ^(.*)$ /public/index.html [L]
          # Prevent directory listing
          Options -Indexes
          # Deny access to sensitive files
          <FilesMatch "\.(env|json|lock|ini|xml|txt)$">
              Order Allow,Deny
              Deny from all
          </FilesMatch>

          <Directory ${root}>
            AllowOverride All
            Require all granted
          </Directory>

        '';
      };
    };
  };

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;
}
