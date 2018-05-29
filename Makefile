
MODE := $(shell cat ~/.bash_mode | awk -F '=' '{print $$2}' )

all: clean initA initB up

default: all

options:
	@echo "make all   -- clean > init > up"
	@echo "make clean -- does a docker-clean and docker-clean-all"
	@echo "make init  -- prepares containers for app run"
	@echo "make up    -- usual dc up"

clean: 
	docker-compose -f docker-compose.$(MODE).yml down && \
	sleep 3 && \
	docker-clean && \
	docker-clean-all

initA:
	docker-compose -f docker-compose.$(MODE).yml build && \
	(docker-compose -f docker-compose.$(MODE).yml up db &) && \
	sleep 3 && \
	docker-compose -f docker-compose.$(MODE).yml exec db /create_database.sh && \
	docker-compose -f docker-compose.$(MODE).yml down	

initB:
	docker-compose -f docker-compose.$(MODE).yml build && \
	(docker-compose -f docker-compose.$(MODE).yml up db &) && \
	sleep 3 && \
	docker-compose -f docker-compose.$(MODE).yml run app python manage.py create_db && \
	docker-compose -f docker-compose.$(MODE).yml down	

up:
	@echo "###"
	@echo "###                HERE WE GO!  "
	@echo "###"

	docker-compose -f docker-compose.$(MODE).yml up
