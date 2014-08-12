This directory contains a partial clone of an actual test salt stack
 used at the time this snapshot was taken.

At that time, it (the complete stack of which this is a part)
performed a successful installation of the package to an
Ubuntu 14.04 server instance.

These files are for example only, and will not be maintained and should not be considered definitive.

Run this (from the project home directory) by:
sudo salt-call --local --file-root=../SaltStack state.highstate
