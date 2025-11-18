VENV ?= .venv
PY ?= $(VENV)/bin/python3
PIP ?= $(VENV)/bin/pip

.PHONY: help venv install clean convert-pdf convert-pptx

help:
	@echo "Available targets: venv install convert-pdf convert-pptx clean"

venv:
	python3 -m venv $(VENV)
	$(PIP) install --upgrade pip

install: venv
	$(PIP) install -r tools/requirements.txt

convert-pdf:
	$(PY) tools/convert_pdf_to_md.py $(FILE) --out $(OUT)

convert-pptx:
	$(PY) tools/convert_pptx_zip_to_md.py $(FILE) --out $(OUT) --images-dir $(IMGDIR)

clean:
	rm -rf $(VENV)
