NS                  := keysoftware
NAME                := mysql
MYSQL_DATABASE      := test_db
MYSQL_ROOT_PASSWORD := password
PORT_3306           := 4360

.PHONY: build
build:
	docker build -t $(NS)/$(NAME) -f Dockerfile .

.PHONY: clean
clean:
	docker stop $(NS)_$(NAME)
	docker rm $(NS)_$(NAME)

.PHONY: clean-image
clean-image:
	docker rmi $(NS)/$(NAME)
	
.PHONY: exec
exec:
	docker exec -it $(NS)_$(NAME) bash

.PHONY: run
run:
	docker run -d --name $(NS)_$(NAME) -p $(PORT_3306):3306 \
									-e MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD) \
									-e MYSQL_DATABASE=$(MYSQL_DATABASE) \
									$(NS)/$(NAME)
	docker ps -a
