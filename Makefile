pg:
	docker-compose up -d db

s3:
	docker-compose up -d s3

db: pg
	mix ecto.setup

server: db s3
	iex -S mix phx.server
