base:
  'app:{{ salt['grains.get']('app', '') }}':
    - match: grain
    - {{ salt['grains.get']('app', '') }}.pillar

