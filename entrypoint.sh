#!/bin/bash

# สั่งให้ Ngrok เจาะท่อพอร์ตเสียง UDP 9987 ออกไปข้างนอกเบื้องหลัง
# (ระบบจะใช้รหัส Token ที่คุณใส่ไว้ในหน้าตั้งค่าของ Render อัตโนมัติ)
ngrok tunnel --protocol udp 9987 &

# รอให้ Ngrok เริ่มทำงานแป๊บนึง
sleep 5

# สั่งเปิดเซิร์ฟเวอร์ TeamSpeak 3 ตามปกติ
./ts3server servername="KimCommuntiy" serverpassword="kimcommuntiy_3317"
