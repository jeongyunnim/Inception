DOCKER_ID := $(shell docker ps -aq)
DOCKER_IMAGE_ID := $(shell docker images -q)
DOCKER_VOLUME := $(shell docker volume ls -q)
PWD := $(shell pwd)

all:
	mkdir -p ./srcs/requirements/mariadb/tools/volume_db/
	mkdir -p ./srcs/requirements/wordpress/tools/volume_wp/

	sed -i '' 's|^\(WP_WWW_PATH\).*|WP_WWW_PATH=$(PWD)/srcs/requirements/wordpress/tools/volume_wp|' "srcs/.env"
	sed -i '' 's|^\(MYSQL_DATA_PATH\).*|MYSQL_DATA_PATH=$(PWD)/srcs/requirements/mariadb/tools/volume_db|' "srcs/.env"
	docker-compose -f ./srcs/compose.yaml build --no-cache 
	docker compose -f ./srcs/compose.yaml up -d
re: fclean
	make all

fclean:
	$(if $(DOCKER_ID), docker rm -f $(DOCKER_ID))
	$(if $(DOCKER_IMAGE_ID), docker rmi $(DOCKER_IMAGE_ID))
	$(if $(DOCKER_VOLUME), docker volume rm $(DOCKER_VOLUME))
	docker system prune -af
	rm -rf ./srcs/requirements/mariadb/tools/volume_db/
	rm -rf ./srcs/requirements/wordpress/tools/volume_wp/