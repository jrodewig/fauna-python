PYTHON_VERSION ?= python-39

install:
	pip install . .[test] .[lint]

test: unit-test integration-test coverage

unit-test:
	python -m coverage run -m pytest tests/unit

integration-test:
	python -m coverage run -m pytest tests/integration

coverage:
	python -m coverage report -m

lint: lint-fauna lint-tests
	python -m yapf -i setup.py

lint-fauna:
	python -m yapf -i --recursive fauna

lint-tests:
	python -m yapf -i --recursive tests

docker-test:
	docker-compose -f tests/docker-compose-tests.yml run --rm --build $(PYTHON_VERSION)
	docker-compose -f tests/docker-compose-tests.yml down
