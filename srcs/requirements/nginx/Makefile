
all:
	docker build -t nginx .
run:
	docker run -it nginx
re: fclean
	make all
fclean:
	docker rm -f $(docker ps -aq)