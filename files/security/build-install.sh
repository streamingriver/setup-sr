#!/bin/bash

cd /opt/tools/security

checkmodule -M -m -o sr.mod sr.te
semodule_package -o sr.pp -m sr.mod
semodule -i sr.pp
