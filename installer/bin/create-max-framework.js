#!/usr/bin/env node

'use strict';

const { spawn, execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const https = require('https');

const VERSION = '1.0.0';
const RELEASE_URL = 'https://github.com/taylorbrook/MAX-MSP_CC_Framework/releases/latest/download/framework.tar.gz';
const MAX_REDIRECTS = 5;

// ---------------------------------------------------------------------------
// Argument parsing
// ---------------------------------------------------------------------------

const args = process.argv.slice(2);

if (args.includes('--version') || args.includes('-v')) {
  console.log(`create-max-framework v${VERSION}`);
  process.exit(0);
}

if (args.includes('--help') || args.includes('-h') || args.length === 0) {
  printUsage();
  process.exit(args.length === 0 ? 1 : 0);
}

const projectName = args[0];

if (projectName.startsWith('-')) {
  console.error(`Error: Unknown flag "${projectName}".`);
  printUsage();
  process.exit(1);
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

const targetDir = path.resolve(projectName);

if (fs.existsSync(targetDir)) {
  console.error(`Error: Directory '${projectName}' already exists.`);
  process.exit(1);
}

console.log(`\nCreating MAX/MSP Claude Code Framework in ${projectName}...\n`);

fs.mkdirSync(targetDir, { recursive: true });

downloadAndExtract(RELEASE_URL, targetDir)
  .then(() => {
    // Create patches directory and active-project config
    const patchesDir = path.join(targetDir, 'patches');
    if (!fs.existsSync(patchesDir)) {
      fs.mkdirSync(patchesDir, { recursive: true });
    }
    fs.writeFileSync(
      path.join(patchesDir, '.active-project.json'),
      JSON.stringify({ active_project: null }, null, 2) + '\n'
    );

    // Initialize git repo
    try {
      execSync('git init', { cwd: targetDir, stdio: 'ignore' });
    } catch (_) {
      // git not available -- not critical
    }

    // Check Python version
    checkPython();

    // Success message
    console.log(`Done! Your MAX/MSP Claude Code Framework project is ready.\n`);
    console.log(`Next steps:`);
    console.log(`  cd ${projectName}`);
    console.log(`  claude`);
    console.log(`  /max-new my-first-patch\n`);
    console.log(`Prerequisites:`);
    console.log(`  - Claude Code (https://docs.anthropic.com/en/docs/claude-code)`);
    console.log(`  - MAX 9 (https://cycling74.com/products/max)`);
    console.log(`  - Python 3.10+ (for the validation engine)\n`);
  })
  .catch((err) => {
    console.error(`\nError: ${err.message || err}`);
    // Clean up partial directory
    try {
      fs.rmSync(targetDir, { recursive: true, force: true });
    } catch (_) {
      // best effort cleanup
    }
    process.exit(1);
  });

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function printUsage() {
  console.log(`
Usage: npx create-max-framework <project-name>

Create a new MAX/MSP Claude Code Framework project.

Options:
  -h, --help      Show this help message
  -v, --version   Show version number

Examples:
  npx create-max-framework my-synth
  npx create-max-framework granular-sampler
`);
}

/**
 * Download a URL, following up to MAX_REDIRECTS redirects,
 * and pipe the response into tar to extract into targetDir.
 */
function downloadAndExtract(url, dir) {
  return new Promise((resolve, reject) => {
    followRedirects(url, 0, (err, response) => {
      if (err) return reject(err);

      if (response.statusCode !== 200) {
        response.resume(); // consume response to free memory
        return reject(new Error(`Download failed with status ${response.statusCode}`));
      }

      const tar = spawn('tar', ['xz', '--strip-components=1', '-C', dir], {
        stdio: ['pipe', 'inherit', 'pipe']
      });

      let tarStderr = '';
      tar.stderr.on('data', (chunk) => { tarStderr += chunk.toString(); });

      tar.on('close', (code) => {
        if (code !== 0) {
          return reject(new Error(`tar extraction failed (exit ${code}): ${tarStderr.trim()}`));
        }
        resolve();
      });

      tar.on('error', (spawnErr) => {
        reject(new Error(`Failed to spawn tar: ${spawnErr.message}`));
      });

      response.pipe(tar.stdin);

      response.on('error', (dlErr) => {
        tar.kill();
        reject(new Error(`Download error: ${dlErr.message}`));
      });
    });
  });
}

/**
 * Follow HTTP(S) redirects up to maxRedirects.
 */
function followRedirects(url, count, callback) {
  if (count >= MAX_REDIRECTS) {
    return callback(new Error('Too many redirects'));
  }

  const protocol = url.startsWith('https') ? https : require('http');

  protocol.get(url, (response) => {
    const status = response.statusCode;

    if (status === 301 || status === 302 || status === 303 || status === 307 || status === 308) {
      const location = response.headers.location;
      if (!location) {
        return callback(new Error('Redirect with no Location header'));
      }
      response.resume(); // discard body
      return followRedirects(location, count + 1, callback);
    }

    callback(null, response);
  }).on('error', (err) => {
    callback(err);
  });
}

/**
 * Check for Python 3.10+ and warn if missing or too old.
 */
function checkPython() {
  try {
    const pyVersion = execSync('python3 --version', { encoding: 'utf8' }).trim();
    const match = pyVersion.match(/Python\s+(\d+)\.(\d+)/);
    if (match) {
      const major = parseInt(match[1], 10);
      const minor = parseInt(match[2], 10);
      if (major < 3 || (major === 3 && minor < 10)) {
        console.warn(`WARNING: Python 3.10+ required. Found: ${pyVersion}`);
      }
    }
  } catch (_) {
    console.warn('WARNING: Python 3 not found. The framework requires Python 3.10+ for the validation engine.');
  }
}
