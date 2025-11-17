# PPTX to Markdown conversion helper

This helper extracts slide text, notes, and images from a `.pptx` file and writes a Markdown file suitable for use with the VSA prompt templates.

Prerequisites
- Python 3.9+
- Install dependencies:

```bash
python -m pip install -r tools/requirements.txt
```

Convert a file:

```bash
python tools/convert_pptx_to_md.py path/to/SwRRT_GX_SW_Upgrade_CFDs_Analysis_06102025.pptx --out sw_upgrade.md --images-dir docs/images --ocr
```

Options
- `--ocr` attempts to extract text from images using Tesseract OCR (install Tesseract separately).
- `--images-dir` controls where embedded images are saved.

Notes
- The script extracts text frames and slide notes; complex layouts may require manual cleanup.
- For large decks consider using `pandoc` on the exported HTML or PDF for a different output style.
