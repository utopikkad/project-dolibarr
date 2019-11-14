build: 
	docker build -t dolibarr .
run:
	docker run -it -p 80:80 dolibarr

