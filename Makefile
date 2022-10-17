VERSION := latest
IMAGE := commonlispbr/starwar:$(VERSION)

build:
	rm -rf release/
	mkdir -p release
	sbcl --load build.lisp
	mv starwar-linux release/
	cp starwar.conf release/
	cp background.mp3 release/
	mv lib/ release/
	cp StarWar.desktop release/
	sed -i 's/starwar.lisp/starwar-linux/g' release/StarWar.desktop

docker-build:
	docker build -t $(IMAGE) .

docker-push: docker-build
	docker push $(IMAGE)

distrobox-export:
	distrobox-export --app starwar --bin /app/starwar-linux --export-path ~/.local/bin
