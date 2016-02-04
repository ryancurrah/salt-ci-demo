{% from "timezone/settings.jinja" import timezone with context %}

set_timezone:
  timezone.system:
    - name: {{ timezone.zone }}
