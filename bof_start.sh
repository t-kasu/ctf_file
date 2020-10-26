#!/bin/bash
#######################################
#事前にrootになっておく　sudo -i
#概要 https://secu.tech.blog/2020/09/15/sql-injection-for-ctf/
#file_name : bof_start.sh
#vulnuserのPWを変更する。
#######################################

#0.rootで実行する前提で
cd
yum -y install gcc
yum -y install gdb

#### 1. ASLRを無効化
#ASLRを無効化することでStackメモリアドレスのランダマイズを無効にする。
sysctl -w kernel.randomize_va_space=0

#### 2. vuln.cのuidを検索して、setreuidにセットする。（ファイルの変更）
#※注意点は、cat /etc/passwdでctfuser1 のuidを確認して、その値をvuln.cに修正する。
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/vuln.c
chmod 755 vuln.c
a=(`cat /etc/passwd | grep vulnuser`)
#区切り文字を:に指定して、切り取り、3つ目を変数bに入れる
b=`echo ${a} | cut -d ':' -f 3`
sed -i vuln.c -e 's/setreuid(1002,1002)/setreuid('$b','$b')/'

#### 3. CanaryおよびDEPを無効化するようコンパイル
gcc -fno-stack-protector -z execstack vuln.c -o vuln.out

#### 4. ユーザの作成
#vulnuserを作成する。
useradd vulnuser
echo userpass | passwd --stdin vulnuser

#### 5. ファイル権限設定（ctfuserフォルダ内に作成する）
#vuln.out→vulnuser所有、setuidビットを立てる。
chown vulnuser:vulnuser vuln.out
chown vulnuser:vulnuser vuln.c
chmod 4755 vuln.out
#一般ユーザも実行できる。BoF成功するとvulnuserのuidになれる。

#### 6. flag1.txt、flag2.txt→vulnuser所有。vulnuserのみ読み取り可能とする。
echo "flag is kirin" > flag1.txt
chown vulnuser flag1.txt
chmod 600 flag1.txt

#### 7. ctfuserフォルダの権限設定
#BoF成功後にvulnuserとしてctfuser内のファイルを見るために以下の権限が必要
chmod 755 /home/vulnuser

#### 8. 4つのファイルを全て/home/vulnuserに移動　
mv /root/flag1.txt /home/vulnuser
mv /root/vuln.c /home/vulnuser
mv /root/vuln.out /home/vulnuser
