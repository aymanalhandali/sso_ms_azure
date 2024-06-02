#!/bin/bash

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Please install Python 3 and try again."
    exit 1
fi

# Create a virtual environment using venv
python3 -m venv env
source env/bin/activate

# Install requirements from requirements.txt
pip install -r backend/requirements.txt

# Deactivate the virtual environment
deactivate
