python-pkgs:
  pkg:
    - installed
    - names:
      - build-essential
      - python-pip
      - python-virtualenv
      - python-dev
      - virtualenvwrapper


/opt/Envs:
  file.directory:  # create a directory for virtual environments
    - user: www-data
    - group: staff
    - file_mode: 775
    - dir_mode: 775

{% if grains['os'] == 'Ubuntu' %}
/etc/environment:
  file.append:
    - text: 'WORKON_HOME=/opt/Envs'
{% endif %}
