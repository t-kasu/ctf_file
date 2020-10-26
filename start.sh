#rootで実行する。
sudo -i
#念のため、ホームディレクトリに移動
cd
#ファイルを取得する
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/sql-injection.py
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/getuser.py
curl -O https://raw.githubusercontent.com/t-kasu/ctf_file/master/user_script.py

#アクセス権の付与
chmod 755 ./sql-injection.py
chmod 755 ./getuser.py
chmod 755 ./user_script.py

#pythonのファイルを実行する。
./user_script.py
