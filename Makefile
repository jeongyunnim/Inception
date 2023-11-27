DOCKER_ID := $(shell docker ps -aq)

all:
	docker compose -f ./srcs/compose.yaml up -d

re: fclean
	make all

fclean:
	docker system prune -a
	docker rm -f $(DOCKER_ID)
	rm -rf ./requirements/mariadb/tools/volume_db/*
	rm -rf ./requirements/nginx/tools/volume_nginx/*
	rm -rf ./requirements/wordpress/tools/volume_wp/*