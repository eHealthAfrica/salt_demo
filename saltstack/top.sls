## this would normally be found at /srv/salt/top.sls
---
# a truncated copy of the actual top.sls used at the moment this script worked.
base:
  '*':
    - users
    - python

  #local:  # on a real Salt Master, put the ID name of the server here.
    - nginx
    - postgres
    - demo-app
