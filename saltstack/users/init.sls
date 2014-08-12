staff:
  group.present:
    - gid: 60000

www-data:
  group.present:
    - gid: 33
  user.present:
    - fullname: Repository Automaton
    - shell: /usr/sbin/nologin
    - uid: 33
    - gid: 33
    - groups:
      - www-data
    - require:
      - group: www-data

testclone:
  user:
    - present
    - fullname: Testing Automaton
    - shell: /usr/sbin/nologin
    - uid: 60001
    - gid: 60000
    - groups:
      - staff
    - optional_groups:
      - www-data
    - require:
      - group: staff

bobz:
  user:
    - present
    - fullname: Robert Z Bannon  # a psuedonym - VDC
    - shell: /bin/bash
    - password: $6$SALTsalt$GukmkEeFiD5TcS6oJWXLscDbwf4e2qNuvoJ66WuBVb7.8JPNR/bl5nnWNIMfExod5uQ3TH4W/nlpPqyTKl/J9/
    - gid: 60000
    - uid: 63999
    - groups:
      - staff
      - sudo
    - optional_groups:
      - www-data
  ssh_auth:
    - present
    - user: bobz
    - source: salt://ssh_keys/bobz.id_rsa.pub
    - require: 
      - user: bobz

# TOTO: add to .bashrc
#export PIP_VIRTUALENV_BASE=$WORKON_HOME
#export PIP_RESPECT_VIRTUALENV=true
#if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#  source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
#fi

