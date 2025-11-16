#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const glob = require('glob');
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

// Search both top-level snippets/ and per-agent snippets folders
const patterns = [
  path.join(__dirname, '..', 'snippets', '*.code-snippets'),
  path.join(__dirname, '..', '.github', 'agents', '*', 'snippets', '*.code-snippets')
];

const files = patterns.flatMap(p => glob.sync(p));
if (files.length === 0) {
  console.error('No snippet files found in snippets/ or .github/agents/*/snippets/');
  process.exit(1);
}

files.forEach(fp => {
  const f = path.basename(fp);
  const err = validateFile(fp);
  if (err) {
    console.error(`${fp}: INVALID JSON — ${err}`);
    failed = true;
  } else {
    console.log(`${fp}: OK`);
  }
});

process.exit(failed ? 2 : 0);
