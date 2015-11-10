{% for user, params in salt['pillar.get']('users').iteritems() %}

{{ user }}:
  user.present:
    - fullname: {{ params['fullname'] }}
    - shell: {{ params['shell'] }}
    - password: {{ params['password'] }}

{% for key in params['ssh_keys'] %}

{{ key }}:
  ssh_auth.present:
    - user: {{ user }}

{% endfor %}
{% endfor %}


{% for group, members in salt['pillar.get']('groups').iteritems() %}

{{ group }}_members:
  group.present:
    - name: {{ group }}
    - members: {{ members }}

{% endfor %}
