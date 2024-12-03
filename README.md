# Quarto / R / Docker Sandbox

I made this for HW2 in René Just's CSE P 590 course at the University of Washington, [Building Data Analysis Pipelines](https://homes.cs.washington.edu/~rjust/courses/CSEP590/). I got tired of fighting with R dependencies on my local machines and decided to fight with them once in Docker and just carry that everywhere.

## Quick Start

Navigate to a directory that contains your `HW2.qmd` file and run the following command:

```bash
docker run -it --rm \
    -p 3838:3838 \
    -v "$(pwd):/app" \
    ghcr.io/kfcampbell/quarto-docker-sandbox:latest \
    quarto preview /app/HW2.qmd --host 0.0.0.0 --port 3838
```

The first time you'll need to download the Docker image (~3.3GB), but after that it'll be cached on your system and `quarto` will begin rendering your notebook immediately.

## Steps for HW2 Users

1. Clone this repo.
2. Copy your .qmd file into the current directory and name it HW2.qmd (or globally find/replace HW2.qmd to your preferred filename). If you have an .ipynb file from Google Colab, convert it using `quarto convert {filename}`.
3. Ensure your .qmd file has a valid header. Mine looks like:
```yaml
---
title: "HW2"
jupyter:
  kernelspec:
    display_name: R
    name: ir
    language: R
engine: knitr
eval: true
format: html
---
```
4. Execute the script: `./run.sh`.
- This will build the Docker image and run it locally. The first build will take a long time (~40 minutes for me), but after that with cached images it will be super quick.
- Navigate to http://localhost:3838 in your browser to see your rendered Quarto notebook. It will reload your changes each time you edit and save your HW2.qmd file.

## Notes

- You must have Docker installed for this to work.
- The process will live-reload and re-render your notebook.
- It can be stopped with Control+C (on Linux + Windows) or Command+C (on Mac).
- Near the bottom of [the Dockerfile](./Dockerfile), I've installed a bunch of R packages I've used for this class.
	- This was to save time so they don't have to be installed every time the notebook is rerendered.
	- If you have more/less packages you want to be installed, make edits to these lines rather than installing packages in your notebook.
- I've hardcoded port 3838 for no good reason. If you want to use a different port, use a global find/replace.
- Installation times: it takes forever to build this thing. That's because the following R dependencies take roughly this long to install:
  - rmarkdown: ~8 minutes
  - tidyverse: ~9.5 minutes
  - jsonlite: ~4.5 minutes
  - GGally: ~7.5 minutes
  - dplyr: ~2 minutes
  - DescTools: ~1.5 minutes
  - sparklyr: ~4 minutes
