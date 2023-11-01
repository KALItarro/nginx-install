#!/bin/bash
weizhi=$(pwd)
yum -y install pcre-devel zlib-devel gcc-c++ &> /dev/null
if [ $? -eq 0 ]
then
echo "基础环境完成搭建"
else
echo "基础环境搭建失败,自动终止此脚本"
exit
fi
useradd -M -s /sbin/nologin nginx &> /dev/null
[ $? -eq 0 ] && echo "创建nginx用户成功" || echo "用户创建失败"
tar xf nginx-*.tar.gz -C /usr/src &> /dev/null
if [ $? -eq 0 ] 
then
echo "解nginx归档包完成"
else
echo "未找到nginx归档包，把归档包放到和脚本同级目录下，已自动终止此脚本"
exit
fi
cd /usr/src/nginx-*
echo '前往nginx安装包'
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_stub_status_module &> /dev/null
[ $? -eq 0 ] && echo "nginx配置成功" || echo "nginx配置失败"
echo '即将开始安装nginx'
echo '4'
sleep 1
echo '3'
sleep 1
echo '2'
sleep 1
echo '1'
sleep 1
make && make install &> /dev/null
[ $? -eq 0 ] && echo "nginx安装成功" || echo "nginx安装失败"
ln -s /usr/local/nginx/sbin/nginx /usr/local/sbin/ &> /dev/null
[ $? -eq 0 ] && echo "优化命令文件路径成功" || echo "优化命令文件路径失败"
cd $weizhi
mv nginx /etc/init.d/
cp /etc/init.d/nginx $weizhi
chmod +x /etc/init.d/nginx 
chkconfig --add nginx
[ -e /etc/init.d/nginx ] && echo "添加系统服务成功" || echo "添加系統服务失败"
echo '----------------------------------------------------'
echo '主文件 		/usr/local/nginx'
echo '网页默认目录 	/usr/local/nginx/html'
echo '主配置文件 	/usr/local/nginx/conf/nginx.conf'
echo '脚本启动文件	/etc/init.d/nginx'
echo '----------------------------------------------------'
echo 'systemctl {start|stop|restart|} nginx'
echo '            开启|关闭|重启|'
echo '----------------------------------------------------'
echo 'TARRO修改了html文件，并把原文件作为备份留了一份  ---> index.html.bak'
mv /usr/local/nginx/html/index.html /usr/local/nginx/html/index.html.bak
echo '<h1>GNUBHCkalitarro</h1>' > /usr/local/nginx/html/index.html
systemctl start nginx
netstat -anpt | grep
if [ $? -eq 0 ] && echo 'nginx服务开启成功' || echo 'nginx服务开启失败 ！！！'
