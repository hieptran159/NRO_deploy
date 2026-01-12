Sau khi "docker compose up -d" phải sửa lại table limitpower
docker exec -it nro_mysql mysql -uroot -p
USE real_data;
RENAME TABLE limitpower TO limitPower;
docker restart nro_server
