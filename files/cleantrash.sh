#!/bin/bash
find /dev/shm -mmin +1 -name "*.ts" -exec rm {} +
