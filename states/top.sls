base:
  'kernel:Linux':
    - match: grain
    - base.timezone
    - base.hosts
    - agents.ntp

  {% for role in salt['grains.get']('roles', []) %}
  'roles:{{ role }}':
    - match: grain
    - roles.{{ role }}
  {% endfor %}

  'app:{{ salt['grains.get']('app', '') }}':
    - match: grain
    - apps.{{ salt['grains.get']('app', '') }}
