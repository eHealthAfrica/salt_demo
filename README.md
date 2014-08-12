salt_demo
=========

This directory contains a Salt script which will deploy a demonstration django project onto an Ubuntu 14.04 server.

It may very likely work with other versions. of Linux (but has not been tested for that.)

It will deploy the standard eHealth Africa server LEPP stack which consists of...

* django (current version)

* virtualenv and virtualenvwrapper

* nginx  # TODO: integrate with runserver and uWSGI

* PostgreSQL (with a database set up for django)

* uWSGI  # TODO: actually do this

* a dummy developer named Bob Z, with a password hash and an ssh public key



Getting Started
---------------

This demo is set up using SaltStack as its deployment engine.

As suggested by Linux standards, statically served pages will be in the /srv directory, 
the operating software will be in /opt, and log files will be in /var/log, all using "dev-track"
as a subdirectory name.

It is possible to use a Salt minion stand-alone, and these instructions assume that you
will be using that method.  If you already operate a real Salt master server, then
you will merge these files and pillar entries into your existing structures.

If you decide to start using SaltStack today, then these files will be a not-too-bad beginning
for your new Salt master server. You would create the /srv/salt and /srv/pillar directories 
on your new master (otherwise, they will be on your new project's web server).

At eHealth Africa, we use the Ubuntu ppa to install salt:

    sudo add-apt-repository ppa:saltstack/salt
    sudo apt-get update
    sudo apt-get install salt-minion

More general instructions for installation can be found at: 
`http://docs.saltstack.com/en/latest/topics/installation/index.html`

__NOTE:__ This script sets up "/opt/Envs" as the default location for Python virtual environments.
If you already have a directory for virtual environments, you will want to create a soft link
for /opt/Envs pointing to your existing directory.

`sudo ln -s /home/<your username>/<your venv directory> /opt/Envs`


[Optional] Create a Salt Pillar to hold your private settings. 
      (unless you already have a Salt master,
      (in which case you will add these needed things to your existing pillar.)
    Rather than having "settings" values in a repository, we will generate them at the time of deployment with Salt.
    Create a directory and "top" file for your pillar:
    
        sudo mkdir /srv/pillar
        sudo chown <yourself>:<your group> /srv/pillar
            # [ Note: on a live Salt Master, this directory should be _very_ restricted. ]
      
    Copy the skeleton pillar files into your new pillar.
    
        cp -r ./saltpillar/* /srv/pillar
        
    Now, edit your settings pillar. Put your own values in for the dbname, password and secret key, etc. 
    These values will be used when creating the PostgreSql database, and will be inserted in your new
    django "settings" environment.
    
        nano /srv/pillar/tut_settings.sls
        
    Then, when you test, do *not* use the "--pillar-root=saltpillar" switch on your command.


Test your installation
----------------------

    ./local_deployment.sh
    
(or, if you created your own local /srv/pillar)

    sudo salt-call --local --file-root=saltstack state.highstate

Add yourself to the "staff" group.

    sudo usermod -a -G staff <your username>

Log off your workstation and log back on to get the new group membership and settings...

Then... set your virtual environment to the tutorial

    workon dev-track

Run syncdb to load your new Postgres database:

    ./manage.py syncdb
    # (be prepared to supply a username and a password for your new django/admin system.)

You should now be able to run the development server::

    ./manage.py runserver

The development server will be running on TCP port 8000 on your local computer...
but nginx will be listening for connections from anywhere on TCP port 80,
 and will proxy them to your runserver on port 8000.

Operate your new test server by surfing to `http://<your new server address>/runserver` . [Note: no ":8000"]


