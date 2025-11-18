# PDF to Markdown helper

This helper extracts textual content from a PDF and writes a simple Markdown file.

Prerequisites
- Python 3.9+
- Install dependencies:

```bash
python -m pip install -r tools/requirements.txt
```

Notes on images and OCR
- `pdfminer.six` extracts text but does not extract images. For images or higher fidelity, install `poppler` (provides `pdftoppm`) and `tesseract` for OCR.
- Example commands to extract page images and OCR them:

```bash
# convert PDF pages to PNG images (requires poppler)
pdftoppm -png input.pdf images/page

# run tesseract OCR on a page
tesseract images/page-1.png page-1 -l eng
```

Usage

```bash
python tools/convert_pdf_to_md.py path/to/doc.pdf --out doc.md

# With OCR (requires `pdftoppm` from poppler and `tesseract`):
python tools/convert_pdf_to_md.py path/to/doc.pdf --out doc.md --ocr --images-dir images
```
