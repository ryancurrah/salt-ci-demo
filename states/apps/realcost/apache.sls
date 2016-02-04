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

apache_sites_enabled_conf:
  file.managed:
    - source: salt://realcost/files/090-realcost.conf
    - name: /etc/apache2/sites-enabled/090-realcost.conf
    - watch_in:
      - service: apache_service
