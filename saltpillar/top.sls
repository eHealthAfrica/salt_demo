---
# Salt Pillar file for: demo-app (sample)
# obviously, this file will be much larger on a production SaltStack deployment -- this one is the simplest possible.
# Author: vernon on 8/7/14 
## normally this would be: /srv/pillar/top.sls
base:
  '*':  # for any minion
    - common
  # 'local':
    - demo-server_settings  # refer to the file "demo-server_settings.sls"
    - demo-app_settings  # refer to the file "demo-app_settings.sls"
# [Note: this is a YAML file. The last two lines are indented by exactly two, and then four spaces.]
...
