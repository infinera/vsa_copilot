#!/usr/bin/env python3
"""
Simple PDF -> Markdown converter using pdfminer.six for text extraction.

Usage:
  python tools/convert_pdf_to_md.py input.pdf --out output.md --images-dir images --ocr

Notes:
- This script extracts page text and writes simple Markdown with page separators.
- For images and better fidelity, use `pdftoppm` (poppler) to convert pages to images and run OCR.
"""
import argparse
import os
from pathlib import Path

try:
    from pdfminer.high_level import extract_text
except Exception:
    extract_text = None
import shutil
import subprocess
import sys

def ensure_dir(p):
    os.makedirs(p, exist_ok=True)

def main():
    parser = argparse.ArgumentParser(description='Convert PDF to Markdown (text extraction)')
    parser.add_argument('input', help='Input PDF file')
    parser.add_argument('--out', '-o', default='output.md')
    parser.add_argument('--images-dir', default='images')
    parser.add_argument('--ocr', action='store_true', help='Use OCR on page images (external pdftoppm + tesseract required)')
    args = parser.parse_args()

    if extract_text is None:
        print('pdfminer.six not available. Install with: pip install pdfminer.six')
        return 1

    pdf_path = args.input
    out_path = args.out
    ensure_dir(os.path.dirname(out_path) or '.')
    ensure_dir(args.images_dir)

    text = extract_text(pdf_path)

    # Split by page markers if present
    if '\f' in text:
        pages = text.split('\f')
    else:
        pages = [text]

    lines = [f'<!-- Converted from: {Path(pdf_path).name} -->\n']
    for i, p in enumerate(pages, start=1):
        lines.append(f'## Page {i}\n')
        lines.append(p.strip() + '\n')
        lines.append('\n---\n')

    with open(out_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))

    print(f'Wrote Markdown to {out_path}')
    if args.ocr:
        # perform OCR on page images using pdftoppm + tesseract when available
        pdftoppm = shutil.which('pdftoppm')
        tesseract = shutil.which('tesseract')
        if pdftoppm is None or tesseract is None:
            print('\nOCR requested but pdftoppm or tesseract not found in PATH. Install poppler and tesseract to enable OCR.')
            print('Example (Debian/Ubuntu): sudo apt install poppler-utils tesseract-ocr')
            print('Manual example: pdftoppm -png input.pdf images/page && tesseract images/page-1.png page-1 -l eng txt')
        else:
            # Render pages to PNGs
            base_out = os.path.join(args.images_dir, 'page')
            ensure_dir(args.images_dir)
            try:
                subprocess.check_call([pdftoppm, '-png', pdf_path, base_out])
            except subprocess.CalledProcessError as e:
                print(f'pdftoppm failed: {e}')
                return 1
            # Find generated images and OCR them
            imgs = sorted([p for p in os.listdir(args.images_dir) if p.startswith('page') and p.endswith('.png')])
            for img in imgs:
                img_path = os.path.join(args.images_dir, img)
                txt_out = os.path.splitext(img_path)[0] + '.txt'
                try:
                    subprocess.check_call([tesseract, img_path, os.path.splitext(img_path)[0], '-l', 'eng'], stdout=sys.stdout, stderr=sys.stderr)
                    # read tesseract output file
                    if os.path.exists(txt_out):
                        with open(txt_out, 'r', encoding='utf-8') as tf:
                            ocr_text = tf.read().strip()
                        if ocr_text:
                            lines.append('\n\n--- OCR PAGE: {} ---\n'.format(img))
                            lines.append(ocr_text + '\n')
                except subprocess.CalledProcessError as e:
                    print(f'tesseract failed on {img_path}: {e}')
            # write updated file with OCR appended
            with open(out_path, 'w', encoding='utf-8') as f:
                f.write('\n'.join(lines))

if __name__ == '__main__':
    raise SystemExit(main())
