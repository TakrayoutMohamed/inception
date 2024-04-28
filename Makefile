WRKDIR = ./srcs/
CHANGEDIR = cd 
DOCKER_COMPOSE_BUILD = docker compose build
DOCKER_COMPOSE_DOWN = docker compose down
DOCKER_COMPOSE_UP = docker compose up

all:  mkdir
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_UP) --build --detach

build_no_cache : mkdir
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_BUILD) --no-cache

exec_db:
	$(CHANGEDIR) $(WRKDIR) && docker exec -it mariadb bash
exec_nginx:
	$(CHANGEDIR) $(WRKDIR) && docker exec -it nginx bash
exec_wp:
	$(CHANGEDIR) $(WRKDIR) && docker exec -it wordpress bash
mkdir: 
	mkdir -p /home/mohtakra/Desktop/data/db
	mkdir -p /home/mohtakra/Desktop/data/wordpress
clean : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_DOWN)

fclean : clean
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_DOWN) -v && docker system prune --all --force
re : fclean all