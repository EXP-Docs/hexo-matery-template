FROM node:19

# 更新源
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean && \
    apt-get update -y && \
    apt-get upgrade -y

# 校准服务器时间
ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt-get install tzdata

# 安装系统必要组件
RUN apt-get install -y curl wget vim zip unzip git telnet net-tools cron logrotate rsyslog procps tofrodos
RUN apt-get install -y python3 python3-pip
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/todos /usr/bin/unix2dos && \
    ln -s /usr/bin/fromdos /usr/bin/dos2unix 
RUN python -m pip install --upgrade pip



# 设置 npm 为国内源
RUN npm config set registry https://registry.npm.taobao.org

# 安装 hexo
RUN npm install hexo-cli -g

# 安装 package.json 声明的插件
COPY ./tpl/hexo /hexo
RUN cd /hexo && npm install

EXPOSE 4000
WORKDIR /hexo

COPY ./entrypoint /
RUN chmod a+x /*.sh && \
    echo "alias ll='ls -alF'" >> /root/.bashrc
ENTRYPOINT [ "/docker-entrypoint.sh" ]


