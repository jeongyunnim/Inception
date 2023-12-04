DOCKER_ID := $(shell docker ps -aq)

all:
	docker compose -f ./srcs/compose.yaml up -d

re: fclean
	make all

fclean:
	docker system prune -a
	$(if $(DOCKER_ID), docker rm -f $(DOCKER_ID))
	rm -rf ./srcs/requirements/mariadb/tools/volume_db/
	rm -rf ./srcs/requirements/nginx/tools/volume_nginx/
	rm -rf ./srcs/requirements/wordpress/tools/volume_wp/