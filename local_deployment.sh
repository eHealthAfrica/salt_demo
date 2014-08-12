#!/bin/bash
sudo salt-call --local --file-root=saltstack --pillar-root=saltpillar state.highstate
