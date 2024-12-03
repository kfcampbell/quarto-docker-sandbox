# Quarto / R / Docker Sandbox

I made this for HW2 in [René Just's CSE P 590](https://homes.cs.washington.edu/~rjust/courses/CSEP590/) course at the University of Washington, Building Data Analysis Pipelines. I got tired of fighting with R dependencies on my local machines and decided to fight with them once in Docker and just carry that everywhere.

## Steps for HW2 Users

1. Copy your .qmd file into the current directory and name it HW2.qmd (or globally find/replace HW2.qmd to your preferred filename). If you have an .ipynb file from Google Colab, convert it using `quarto convert {filename}`.
2. Ensure your .qmd file has a valid header. Mine looks like:
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
3. Execute the script: `./run.sh`.
- This will build the Docker image and run it locally. The first build will take a long time (~30 minutes for me), but after that with cached images it will be super quick.
- Navigate to http://localhost:3838 in your browser to see your rendered Quarto notebook. It will reload your changes each time you edit and save your HW2.qmd file.

## Notes

- You must have Docker installed for this to work.
- The process will live-reload and re-render your notebook.
- It can be stopped with Control+C (on Linux + Windows) or Command+C (on Mac).
- Starting on line 40 of [the Dockerfile](./Dockerfile#L40), I've installed a bunch of packages I've used for this class.
	- This was to save time so they don't have to be installed every time the notebook is rerendered.
	- If you have more/less packages you want to be installed, make edits to what comes after line rather than installing packages in your notebook.
- I've hardcoded port 3838 for no good reason. If you want to use a different port, use a global find/replace.
