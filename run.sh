#! /bin/bash
set -e

docker build --build-arg ARCH=$(dpkg --print-architecture) -t quarto-live .
docker run -it --rm \
    -p 3838:3838 \
    -v "$(pwd):/app" \
    quarto-live \
    quarto preview /app/HW2.qmd --host 0.0.0.0 --port 3838
