FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. อัปเดตระบบ ติดตั้งเครื่องมือแตกไฟล์ และดาวน์โหลด TeamSpeak 3 Server
RUN apt-get update && apt-get install -y wget tar bzip2 curl && \
    wget https://files.teamspeak-services.com/releases/server/3.13.7/teamspeak3-server_linux_amd64-3.13.7.tar.bz2 && \
    tar -xjvf teamspeak3-server_linux_amd64-3.13.7.tar.bz2 && \
    mv teamspeak3-server_linux_amd64 /ts3server && \
    touch /ts3server/.ts3server_license_accepted

# 2. ติดตั้ง Ngrok สายตรงลงเครื่องจำลอง
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.p4/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt-get update && apt-get install ngrok -y

WORKDIR /ts3server

# ดึงไฟล์สคริปต์รันคู่ขนานมาเปิดใช้งาน
COPY entrypoint.sh /ts3server/entrypoint.sh
RUN chmod +x /ts3server/entrypoint.sh

# สั่งรันผ่านตัวมัดรวมคู่ขนาน
ENTRYPOINT ["/ts3server/entrypoint.sh"]
