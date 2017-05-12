#!/bin/bash

# make sure there are no kitchen/vagrant instances
# connected to the current directory


eval "$(chef shell-init bash)"

kitchen destroy

vms=$( vboxmanage list vms | \
             grep '"kitchen-' | \
             tr -d '{}' | \
             awk '{print $2}' )

for vm in $vms; do
    echo "Forcefully deleting virtualbox $vm"
    pid=$( ps awx | \
                 grep -i vboxheadless | \
                 grep $vm | \
                 awk '{print $1}' )
    if [ -n "$pid" ]; then
        echo " .. and its little process too! ($pid)"
        kill -9 $pid
        sleep 5
    fi
    vboxmanage unregistervm $vm --delete
done


# we need a vagrant w/ the global-status command for the following
#
# here=$( basename $( pwd ) )
#
# vms=$( vagrant global-status | \
# 	     grep -E '^[0-9a-f]{7}' | \
# 	     grep "$here"| \
# 	     awk '{print $1}' )
#
# for vm in $vms; do
#     echo vagrant destroy -f $vm
# done

# Local Variables:
# indent-tabs-mode: nil
# End:
