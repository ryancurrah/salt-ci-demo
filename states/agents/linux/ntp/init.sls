{% from 'ntp/settings.jinja' import ntp with context %}

ntp_client:
  pkg.installed:
    - name: {{ ntp.pkg }} 

  service.running:
    - name: {{ ntp.service }}

  file.managed:
    - name: {{ ntp.conf }}
    - contents: |
        driftfile /var/lib/ntp/ntp.drift
        {% for server in ntp.servers -%}
        server {{ server }}
        {% endfor %}
    - watch_in:
      - cmd: ntp_client

  cmd.wait:
    - name: service {{ ntp.service }} stop; {{ ntp.bin }} -gq
    - watch_in:
      - service: ntp_client
