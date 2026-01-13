Sau khi "docker compose up -d" phải sửa lại table limitpower \n
docker exec -it nro_mysql mysql -uroot -p \n
USE real_data; \n
RENAME TABLE limitpower TO limitPower; \n
docker restart nro_server \n
