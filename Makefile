activate-env:
	@if ! conda env list | grep -q "credeau-docs"; then \
		conda create -n credeau-docs python=3.11 -y; \
		pip install -r requirements.txt
	fi
	conda activate credeau-docs

install:
	pip install -r requirements.txt

build:
	mkdocs build

serve:
	mkdocs serve

deploy:
	mkdocs gh-deploy

clean:
	rm -rf site
