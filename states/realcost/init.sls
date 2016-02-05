include:
  - realcost.apache

realcost_app_dir:
  file.directory:
    - name: /var/www/realcost
    - makedirs: true
    - mode: 750 
    - user: www-data
    - recurse:
      - user

realcost_app_latest:
  git.latest:
    - name: https://github.com/ryancurrah/realcost
    - target: /var/www/realcost
    - force_clone: true
    - require:
      - file: realcost_app_dir
    - watch_in:
      - service: apache_service

realcost_venvs_dir:
  file.directory:
    - name: /var/venvs/realcost
    - makedirs: true
    - mode: 750 
    - user: www-data
    - recurse:
      - user

realcost_venv:
  virtualenv.managed:
    - name: /var/venvs/realcost
    - requirements: /var/www/realcost/requirements.txt 
    - system_site_packages: false
    - user: www-data
    - require:
      - git: realcost_app_latest
      - file: realcost_venvs_dir
    - watch_in:
      - service: apache_service

