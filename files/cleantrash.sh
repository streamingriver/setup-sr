#!/bin/bash
find /mnt/streams -mmin +1 -name "*.ts" -exec rm {} +
