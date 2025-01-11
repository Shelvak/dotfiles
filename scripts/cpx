#!/bin/sh
# SCRIPT:  copyx ver 1.0, 14-9-2011
# PURPOSE: Copies files and shows the progress of copying.
# Usage Example: ./copyx my100gbfiles.tar.gz /path/to/destination/my100gbfiles.tar.gz
copyx()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        cal += $NF
            if (cal % 10 == 0) {
               percentage = cal / totalsize * 100
               printf "%3d%% [", percentage
               for (i=0;i<=percentage;i++)
                  printf "="
               printf ">"
               for (i=percentage;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' totalsize=$(stat -c '%s' "${1}") cal=0
}
