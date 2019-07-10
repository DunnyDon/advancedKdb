#!/bin/bash
#Shows all q processes running under user account

ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep

