#!/usr/bin/env python3
"""
Lightweight PPTX -> Markdown converter using only the standard library.

It reads the .pptx as a ZIP, extracts slide XML (`ppt/slides/slideN.xml`), notes
(`ppt/notesSlides/notesSlideN.xml`), and media files (`ppt/media/*`). It writes a
Markdown file and copies media files to the specified images directory.

This is a best-effort converter intended for environments without `python-pptx`.
"""
import argparse
import os
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path

NS = {
    'a': 'http://schemas.openxmlformats.org/drawingml/2006/main',
    'p': 'http://schemas.openxmlformats.org/presentationml/2006/main',
}

def ensure_dir(path):
    os.makedirs(path, exist_ok=True)

def extract_text_from_xml(xml_bytes):
    root = ET.fromstring(xml_bytes)
    texts = []
    # find all text elements <a:t>
    for t in root.findall('.//{http://schemas.openxmlformats.org/drawingml/2006/main}t'):
        if t.text:
            texts.append(t.text)
    return '\n'.join(texts).strip()

def get_slide_files(z):
    slides = []
    for name in z.namelist():
        if name.startswith('ppt/slides/slide') and name.endswith('.xml'):
            slides.append(name)
    slides.sort()
    return slides

def get_notes_files(z):
    notes = {}
    for name in z.namelist():
        if name.startswith('ppt/notesSlides/notesSlide') and name.endswith('.xml'):
            # map slide index by parsing number
            notes[name] = name
    return notes

def get_media_files(z):
    media = []
    for name in z.namelist():
        if name.startswith('ppt/media/'):
            media.append(name)
    return media

def main():
    parser = argparse.ArgumentParser(description='PPTX -> Markdown (zip fallback)')
    parser.add_argument('input', help='Path to .pptx file')
    parser.add_argument('--out', '-o', default='output.md', help='Output Markdown file')
    parser.add_argument('--images-dir', default='images', help='Directory to write extracted images')
    args = parser.parse_args()

    pptx = args.input
    out = args.out
    images_dir = args.images_dir
    ensure_dir(os.path.dirname(out) or '.')
    ensure_dir(images_dir)

    with zipfile.ZipFile(pptx, 'r') as z:
        slides = get_slide_files(z)
        media = get_media_files(z)
        notes_map = {Path(p).stem.replace('notesSlide',''): p for p in z.namelist() if p.startswith('ppt/notesSlides/notesSlide')}

        md_lines = [f'<!-- Converted from: {Path(pptx).name} (zip fallback) -->\n']

        # extract media files to images_dir
        media_map = {}
        for m in media:
            fname = os.path.basename(m)
            outpath = os.path.join(images_dir, fname)
            with open(outpath, 'wb') as f:
                f.write(z.read(m))
            media_map[fname] = outpath

        for idx, slide_path in enumerate(slides, start=1):
            slide_xml = z.read(slide_path)
            slide_text = extract_text_from_xml(slide_xml)

            # attempt to derive a title: first non-empty text line
            title = ''
            for line in slide_text.splitlines():
                s = line.strip()
                if s:
                    title = s
                    break

            header = title if title else f'Slide {idx}'
            md_lines.append(f'## {header}\n')
            if slide_text:
                # skip the first line if it was used as title
                lines = slide_text.splitlines()
                if lines and lines[0].strip() == title:
                    body = '\n'.join(lines[1:]).strip()
                else:
                    body = '\n'.join(lines).strip()
                if body:
                    md_lines.append(body + '\n')

            # link any images extracted (best-effort: include all media)
            for fname, path in media_map.items():
                rel = os.path.relpath(path, os.path.dirname(os.path.abspath(out)) or '.')
                md_lines.append(f'![{fname}]({rel})\n')

            # add notes if present
            # notes naming doesn't always map; attempt using slide index
            notes_name = f'ppt/notesSlides/notesSlide{idx}.xml'
            try:
                notes_xml = z.read(notes_name)
                notes_text = extract_text_from_xml(notes_xml)
                if notes_text:
                    md_lines.append('\n**Notes:**\n')
                    md_lines.append(notes_text + '\n')
            except KeyError:
                pass

            md_lines.append('\n---\n')

    with open(out, 'w', encoding='utf-8') as f:
        f.write('\n'.join(md_lines))

    print(f'Wrote Markdown to {out} and images to {images_dir}')

if __name__ == '__main__':
    main()
