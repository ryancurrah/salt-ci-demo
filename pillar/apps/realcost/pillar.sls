# ``apache`` formula configuration:
apache:

  # lookup section overrides ``map.jinja`` values
  lookup:
    server: apache2
    service: apache2

    vhostdir: /etc/apache2/sites-available
    confdir: /etc/apache2/conf.d
    confext: .conf
    logdir: /var/log/apache2
    wwwdir: /srv/apache2
  
    # apache version (generally '2.2' or '2.4')
    version: '2.2'

    # ``apache.mod_wsgi`` formula additional configuration:
    mod_wsgi: mod_wsgi

  # ``apache.vhosts`` formula additional configuration:
  sites:
    example.net:
      template_file: salt://apache/vhosts/minimal.tmpl

    example.com: # must be unique; used as an ID declaration in Salt.
      enabled: True
      template_file: salt://apache/vhosts/standard.tmpl # or redirect.tmpl or proxy.tmpl

      ####################### DEFAULT VALUES BELOW ############################
      # NOTE: the values below are simply default settings that *can* be
      # overridden and are not required in order to use this formula to create
      # vhost entries.
      #
      # Do not copy the values below into your Pillar unless you intend to
      # modify these vaules.
      ####################### DEFAULT VALUES BELOW ############################
      template_engine: jinja

      interface: '*'
      port: '80'

      ServerName: example.com # uses the unique ID above unless specified
      ServerAlias: www.example.com

      ServerAdmin: webmaster@example.com

      LogLevel: warn
      ErrorLog: /path/to/logs/example.com-error.log # E.g.: /var/log/apache2/example.com-error.log
      CustomLog: /path/to/logs/example.com-access.log # E.g.: /var/log/apache2/example.com-access.log

      DocumentRoot: /path/to/www/dir/example.com # E.g., /var/www/example.com

      SSLCertificateFile: /etc/ssl/mycert.pem # if ssl is desired
      SSLCertificateKeyFile: /etc/ssl/mycert.pem.key # if key for cert is needed or in an extra file
      SSLCertificateChainFile: /etc/ssl/mycert.chain.pem # if you require a chain of server certificates file

      Directory:
        # "default" is a special case; Adds ``/path/to/www/dir/example.com``
        # E.g.: /var/www/example.com
        default:
          Options: -Indexes FollowSymLinks
          Order: allow,deny    # For Apache < 2.4
          Allow: from all      # For apache < 2.4
          Require: all granted # For apache > 2.4.
          AllowOverride: None
          Formula_Append: |
            Additional config as a
            multi-line string here

      # if template is 'redirect.tmpl'
      # RedirectSource: '/'
      # RedirectTarget: 'http://www.example.net'

      # if template is 'proxy.tmpl'
      # ProxyPreserveHost: 'On'
      # ProxyRoute: 
      #   my sample route:
      #      ProxyPassSource: '/'
      #      ProxyPassTarget: 'http://www.example.net'
      #      ProxyPassReverseSource: '/'
      #      ProxyPassReverseTarget: 'http://www.example.net'

      Alias:
        /docs: /usr/share/docs

      Location:
        /docs:
          Order: allow,deny    # For Apache < 2.4
          Allow: from all      # For apache < 2.4
          Require: all granted # For apache > 2.4.
          Formula_Append: |
            Additional config as a
            multi-line string here

      Formula_Append: |
        Additional config as a
        multi-line string here

  # ``apache.debian_full`` formula additional configuration:
  register-site:
    # any name as an array index, and you can duplicate this section
    UNIQUE_VALUE_HERE:
      name: 'my name'
      path: 'salt://path/to/sites-available/conf/file'
      state: 'enabled'
      # Optional - use managed file as Jinja Template
      #template: true
      #defaults:
      #  custom_var: "default value"

  modules:
    enabled:  # List modules to enable
      - ldap
      - ssl
    disabled:  # List modules to disable
      - rewrite

  # KeepAlive: Whether or not to allow persistent connections (more than
  # one request per connection). Set to "Off" to deactivate.
  keepalive: 'On'

  security:
    # can be Full | OS | Minimal | Minor | Major | Prod
    # where Full conveys the most information, and Prod the least.
    ServerTokens: Prod

  # ``apache.mod_remoteip`` formula additional configuration:
  mod_remoteip:
    RemoteIPHeader: X-Forwarded-For
    RemoteIPTrustedProxy:
      - 10.0.8.0/24
      - 127.0.0.1
