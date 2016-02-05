{% for ipv4 in salt['network.ip_addrs'](include_loopback=False) %}
etc_hosts:
  host.present:
    - ip: {{ ipv4 }}
    - names:
      - {{ salt['grains.get']('host', '') }} 
      - {{ salt['grains.get']('fqdn', '') }}
{% endfor %}
