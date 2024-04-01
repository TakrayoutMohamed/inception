WRKDIR = ./srcs/
CHANGEDIR = cd 
DOCKER_COMPOSE = docker-compose 

build : 
	$(CHANGEDIR) $(WRKDIR)
	docker-compose build --no-cache
up : 
	docker-compose up --detach
down : 
	docker-compose down