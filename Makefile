WRKDIR = ./srcs/
CHANGEDIR = cd 
DOCKER_COMPOSE_BUILD = docker-compose build
DOCKER_COMPOSE_DOWN = docker-compose down
DOCKER_COMPOSE_UP = docker-compose up


build : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_BUILD)
build_no_cache : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_BUILD) --no-cache
up : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_UP)
up_d : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_UP) --detach
down : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_DOWN)
fdown : 
	$(CHANGEDIR) $(WRKDIR) && $(DOCKER_COMPOSE_DOWN) -v
exec_db:
	$(CHANGEDIR) $(WRKDIR) && docker exec -it alva_cont_db bash
exec_nginx:
	$(CHANGEDIR) $(WRKDIR) && docker exec -it alva_cont_nginx bash
exec_wp:
	$(CHANGEDIR) $(WRKDIR) && docker exec -it alva_cont_wp bash
clean:  down

fclean : clean
	$(DOCKER_COMPOSE) down