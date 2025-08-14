#!/usr/bin/env bash
set -e

# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate

# Install project and Python dependencies
pip install --upgrade pip
pip install -e .

# Install testing utilities
pip install pytest

# Install JavaScript dependencies
npm install
# Optional: rebuild JS bundle
# npm run build
