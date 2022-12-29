# This enables getty on all physical serial interfaces seen on a Linux host. Quick serial login TTYs for all.

{% for serialDeviceNumber in salt['cmd.run']("awk -F':' '/uart:[0-9]/{ print $1 }' /proc/tty/driver/serial").split() %}
{% set serialDevice = 'ttyS' + serialDeviceNumber %}

enable_getty_for_{{serialDevice}}:
  service.running:
    - name: getty@{{serialDevice}}
    - enable: true

{% endfor %}
