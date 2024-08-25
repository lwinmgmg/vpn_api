#!/bin/bash
echo "Started Black Formatter"
poetry run black vpn_api
echo "Done Black Formatter"

echo "Started Flake8 Linter"
poetry run flake8 vpn_api
echo "Done Flake8 Formatter"

echo "Started Pylint Linter"
poetry run pylint vpn_api
echo "Done Pylint Linter"
