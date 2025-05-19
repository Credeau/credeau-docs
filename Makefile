install:
	pip install -r requirements.txt

build:
	mkdocs build

serve:
	mkdocs serve

deploy:
	mkdocs gh-deploy --clean

clean:
	rm -rf site
