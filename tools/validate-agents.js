#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

const agentsDir = path.join(__dirname, '..', '.github', 'agents');
const manifestPath = path.join(__dirname, '..', 'manifest.json');

let failed = false;

function die(msg) { console.error(msg); failed = true; }

if (!fs.existsSync(agentsDir)) {
  die('.github/agents directory missing');
}

function findAgentYamls(dir) {
  const results = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const e of entries) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) results.push(...findAgentYamls(p));
    else if (e.isFile() && e.name === 'agent.yml') results.push(p);
  }
  return results;
}

const agentFiles = findAgentYamls(agentsDir);
if (agentFiles.length === 0) die('No agent.yml files found in .github/agents');

let manifest = null;
try { manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8')); } catch (e) { die('Cannot read manifest.json: '+e.message); }

agentFiles.forEach(fp => {
  try {
    const doc = yaml.load(fs.readFileSync(fp, 'utf8'));
    const rel = path.relative(path.join(__dirname, '..'), fp);
    if (!doc.prompt) die(`${rel} missing 'prompt' field`);
    // normalize prompt path
    const promptPath = path.join(__dirname, '..', doc.prompt);
    if (!fs.existsSync(promptPath)) die(`${rel} references missing prompt: ${doc.prompt}`);
    const normPrompt = doc.prompt.replace(/^[\.\/]+/, '');
    const manifestIncludes = manifest.files.some(f => f.replace(/^[\.\/]+/, '') === normPrompt);
    if (!manifestIncludes) {
      die(`${rel} prompt not listed in manifest.json: ${doc.prompt}`);
    }
  } catch (e) { die(`${fp} parse error: ${e.message}`); }
});

if (failed) process.exit(2);
console.log('All agents validated OK');
process.exit(0);
