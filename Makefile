DOCKER_ID := $(shell docker ps -aq)
DOCKER_IMAGE_ID := $(shell docker images -q)
DOCKER_VOLUME := $(shell docker volume ls -q)
PWD := $(shell pwd)
DB_VOL = /home/jeseo/data/mariadb_vol
WP_VOL = /home/jeseo/data/wordpress_vol

all:
	mkdir -p ${DB_VOL}
	mkdir -p ${WP_VOL}

	docker compose -f ./srcs/compose.yaml build --no-cache 
	docker compose -f ./srcs/compose.yaml up -d

local:
	mkdir -p ${PWD}/srcs/requirements/mariadb/tools/db_vol
	mkdir -p ${PWD}/srcs/requirements/wordpress/tools/wp_vol

	docker compose -f ./srcs/local.yaml build --no-cache 
	docker compose -f ./srcs/local.yaml up -d


up:
	docker compose -f ./srcs/compose.yaml up -d

down:
	docker compose -f ./srcs/compose.yaml down -d

re: fclean
	make all

fclean:
	$(if $(DOCKER_ID), docker rm -f $(DOCKER_ID))
	$(if $(DOCKER_IMAGE_ID), docker rmi $(DOCKER_IMAGE_ID))
	$(if $(DOCKER_VOLUME), docker volume rm $(DOCKER_VOLUME))
	docker system prune -af
	rm -rf ${DB_VOL}
	rm -rf ${WP_VOL}