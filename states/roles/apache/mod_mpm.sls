{% if grains['os_family']=="Debian" %}
{% from "apache/map.jinja" import apache with context %}
{% set mpm_module = salt['pillar.get']('apache:mpm:module', 'mpm_prefork') %}

include:
  - apache

a2enmod {{ mpm_module }}:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/{{ mpm_module }}.load
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart
  file.managed:
    - name: /etc/apache2/mods-available/{{ mpm_module }}.conf
    - template: jinja
    - source:
      - salt://apache/files/Debian/mpm/{{ mpm_module }}.conf.jinja
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart

# Deactivate the other mpm modules as a previous step
{% for mod in ['mpm_prefork', 'mpm_worker', 'mpm_event'] if not mod == mpm_module %}
a2dismod {{ mod }}:
  cmd.run:
    - onlyif: test -e /etc/apache2/mods-enabled/{{ mod }}.load
    - require:
      - pkg: apache
    - require_in:
      - cmd: a2enmod {{ mpm_module }}
    - watch_in:
      - module: apache-restart
{% endfor %}

{% endif %}
