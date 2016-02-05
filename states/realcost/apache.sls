apache_pkgs:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-wsgi

apache_service:
  service.running:
    - name: apache2
    - enable: true
    - require:
      - pkg: apache_pkgs

apache_disable_default_site:
  file.absent:
    - name: /etc/apache2/sites-enabled/000-default.conf
    - watch_in:
      - service: apache_service

apache_sites_enabled_conf:
  file.managed:
    - source: salt://realcost/files/001-realcost.conf
    - name: /etc/apache2/sites-enabled/001-realcost.conf
    - mode: 640
    - user: www-data
    - watch_in:
      - service: apache_service

