#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const dir = path.join(__dirname, '..', 'snippets');
let failed = false;

function validateFile(fp) {
  try {
    const content = fs.readFileSync(fp, 'utf8');
    JSON.parse(content);
    return null;
  } catch (err) {
    return err.message;
  }
}

const files = fs.readdirSync(dir).filter(f => f.endsWith('.code-snippets'));
if (files.length === 0) {
  console.error('No snippet files found in snippets/');
  process.exit(1);
}

files.forEach(f => {
  const fp = path.join(dir, f);
  const err = validateFile(fp);
  if (err) {
    console.error(`${f}: INVALID JSON — ${err}`);
    failed = true;
  } else {
    console.log(`${f}: OK`);
  }
});

process.exit(failed ? 2 : 0);
