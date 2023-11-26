
all:
	docker compose up

re: fclean
	make all

fclean:
	docker system prune -a
	rm -rf ./requirements/mariadb/tools/volume_db/*
	touch ./requirements/mariadb/tools/volume_db/.keep
	rm -rf ./requirements/nginx/tools/volume_nginx/*
	touch ./requirements/nginx/tools/volume_nginx/.keep
	rm -rf ./requirements/wordpress/tools/volume_wp/*
	touch ./requirements/wordpress/tools/volume_wp/.keep