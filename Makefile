install:
	pip install -r requirements.txt

build:
	mkdocs build

serve:
	mkdocs serve

deploy:
	mkdocs gh-deploy --clean --remote-branch gh-pages --remote-name origin

clean:
	rm -rf site
