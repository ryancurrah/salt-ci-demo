include:
  - realcost.apache

realcost_app_dir:
  file.directory:
    - name: /var/www/realcost
    - makedirs: true
    - user: www-data
    - recurse:
      - user

realcost_git:
  git.latest:
    - name: https://github.com/ryancurrah/realcost
    - target: /var/www/realcost
    - force_clone: true
    - require:
      - file: realcost_app_dir

realcost_venv_dir:
  file.directory:
    - name: /var/virtualenvs/realcost
    - makedirs: true
    - user: www-data
    - recurse:
      - user

realcost_virtualenv:
  virtualenv.managed:
    - name: /var/virtualenvs/realcost
    - requirements: /var/www/realcost/requirements.txt 
    - system_site_packages: False
    - user: www-data
    - require:
      - file: realcost_app_dir
      - git: realcost_git
      - file: realcost_venv_dir
    - require_in:
      - file: apache_sites_enabled_conf 
