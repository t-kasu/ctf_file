#!/bin/bash
for i in {1..13};do
  useradd gp${i}_user
  echo pass_gp${i} | passwd --stdin gp${i}_user
  cp /root/getuser.py /home/gp${i}_user
  chmod 666 /home/gp${i}_user/getuser.py
  cp /root/sql-injection.py /home/gp${i}_user
  chmod 700 /home/gp${i}_user/sql-injection.py
  sed -i /home/gp${i}_user/sql-injection.py -e 's/5000/500'$i'/' 
done
