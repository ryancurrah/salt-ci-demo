base:
  'kernel:Linux':
    - match: grain
    - base.timezone
    - base.hosts
    - agents.ntp

  {% for role in salt['grains.get']('roles', []) %}
  'roles:{{ role }}':
    - match: grain
    - {{ role }}
  {% endfor %}

  'app:{{ salt['grains.get']('app', '') }}':
    - match: grain
    - {{ salt['grains.get']('app', '') }}
