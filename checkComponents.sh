ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep
