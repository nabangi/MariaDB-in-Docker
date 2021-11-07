#!/bin/bash
exlock_now || exit 1
/usr/bin/php check_master_slave_status.php
