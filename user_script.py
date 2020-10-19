#!/usr/bin/python3.7
import subprocess
for i in range(1,13):
    cmd1="useradd gp%s_user" % i
    cmd2="echo pass_gp%s_west | passwd --stdin gp%s_user" %(i,i)
    cmd3="cp /root/getuser.py /home/gp%s_user" % i
    cmd4="chmod 666 /home/gp%s_user/getuser.py" % i
    cmd5="cp /root/sql-injection.py /home/gp%s_user" % i
    cmd6="chmod 700 /home/gp%s_user/sql-injection.py" % i

    print(subprocess.call(cmd1, shell=True))
    print(subprocess.call(cmd2, shell=True))
    print(subprocess.call(cmd3, shell=True))
    print(subprocess.call(cmd4, shell=True))
    print(subprocess.call(cmd5, shell=True))
    print(subprocess.call(cmd6, shell=True))

###### I wanted to write this code. but it doesn't work well.    
#    cmd=[cmd1,cmd2,cmd3,cmd4,cmd5,cmd6]
#    for j in cmd:
#        print(j)
#        print(subprocess.call(cmd, shell=True))
