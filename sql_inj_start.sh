#!/bin/bash
#######################################
# file_name : sql_inj_start.sh
# 事前にrootになっておく　sudo -i
# セキュリティグループの設定をすべき。
#   out => in ssh 5001-5013
#   in => out 172.16.0.0/16 のみ許可?
# ユーザのパスワードも変えておく
#######################################

#### 1. 初期設定など
#念のため、ホームディレクトリに移動
cd

#関連するソフトを入れる
#nmapは別の問題用である
yum -y install nmap
#yum -y install python3
curl -kL https://bootstrap.pypa.io/get-pip.py | python
pip install Flask

#### 2. ファイルを取得する
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/sql-injection.py
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/getuser.py
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/user_script.sh

#### 3. 実行権の付与
chmod +x ./sql-injection.py
chmod +x ./getuser.py
chmod +x ./user_script.sh

#### 4. ユーザを作成したりフォルダを作ったり、アクセス権を変えるなどのbashを実行する。
#その前にパスワードを変える。任意の文字に
sed -i '/passwd --stdin/ s/pass_gp${i}/pass_gp${i}_west/' user_script.sh
./user_script.sh

#### 5.SSHの設定ファイルの変更
#sshでのPWログインを許可する。
sed -i '/^#PasswordAuthentication yes/ s/#//' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication no/ s/PasswordAuthentication no/#PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

#######################################
# ここからは流し込みというよりは、個別実行がいいのでではないか
# 実行はrootで行う
nohup /home/gp1_user/sql-injection.py &
nohup /home/gp2_user/sql-injection.py &
nohup /home/gp3_user/sql-injection.py &
nohup /home/gp4_user/sql-injection.py &
nohup /home/gp5_user/sql-injection.py &
nohup /home/gp6_user/sql-injection.py &
nohup /home/gp7_user/sql-injection.py &
nohup /home/gp8_user/sql-injection.py &
nohup /home/gp9_user/sql-injection.py &
nohup /home/gp10_user/sql-injection.py &
nohup /home/gp11_user/sql-injection.py &
nohup /home/gp12_user/sql-injection.py &

