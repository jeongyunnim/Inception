DOCKER_ID := $(shell docker ps -aq)
DOCKER_IMAGE_ID := $(shell docker images -q)
PWD := $(shell pwd)

all:
	sed -i '' 's|^\(WP_WWW_PATH\).*|WP_WWW_PATH=$(PWD)/srcs/requirements/wordpress/tools/volume_wp|' "srcs/.env"
	docker-compose -f ./srcs/compose.yaml build --no-cache
	docker compose -f ./srcs/compose.yaml up -d 
re: fclean
	make all

fclean:
	$(if $(DOCKER_ID), docker rm -f $(DOCKER_ID))
	$(if $(DOCKER_IMAGE_ID), docker rmi $(DOCKER_IMAGE_ID))
	docker system prune -a --volumes
	rm -rf ./srcs/requirements/mariadb/tools/volume_db/
	mkdir -p ./srcs/requirements/mariadb/tools/volume_db/
	rm -rf ./srcs/requirements/wordpress/tools/volume_wp/
	mkdir -p ./srcs/requirements/wordpress/tools/volume_wp/