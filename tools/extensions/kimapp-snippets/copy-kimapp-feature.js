#!/usr/bin/env node

/**
 * This script copies the kimapp_feature JavaScript code from the original location
 * to the VS Code extension directory before packaging/publishing.
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Source and destination paths
const SOURCE_DIR = path.join(__dirname, '..', '..', '..', 'template_generators', 'kimapp_feature');
const DEST_DIR = path.join(__dirname, 'src', 'kimapp_feature');

// Function to copy directory recursively
function copyDirectory(source, destination) {
  // Create destination directory if it doesn't exist
  if (!fs.existsSync(destination)) {
    fs.mkdirSync(destination, { recursive: true });
  }

  // Read all files/directories from source
  const entries = fs.readdirSync(source, { withFileTypes: true });

  for (const entry of entries) {
    const sourcePath = path.join(source, entry.name);
    const destPath = path.join(destination, entry.name);

    // Skip node_modules
    if (entry.name === 'node_modules') {
      continue;
    }

    if (entry.isDirectory()) {
      // Recursively copy directories
      copyDirectory(sourcePath, destPath);
    } else {
      // Copy files
      fs.copyFileSync(sourcePath, destPath);
    }
  }
}

// Main function
function main() {
  console.log(`Copying kimapp_feature from ${SOURCE_DIR} to ${DEST_DIR}...`);

  try {
    // Check if source directory exists
    if (!fs.existsSync(SOURCE_DIR)) {
      console.error(`Source directory not found: ${SOURCE_DIR}`);
      process.exit(1);
    }

    // Remove destination directory if it exists
    if (fs.existsSync(DEST_DIR)) {
      console.log('Removing existing destination directory...');
      fs.rmSync(DEST_DIR, { recursive: true, force: true });
    }

    // Copy the directory
    copyDirectory(SOURCE_DIR, DEST_DIR);

    // Install dependencies in the copied directory
    console.log('Installing dependencies in the copied directory...');
    execSync('npm install --production', { 
      cwd: DEST_DIR, 
      stdio: 'inherit' 
    });

    console.log('Successfully copied kimapp_feature to the VS Code extension!');
  } catch (error) {
    console.error('Error copying kimapp_feature:', error);
    process.exit(1);
  }
}

// Run the script
main();
