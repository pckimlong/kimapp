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
      console.error(`Current directory: ${__dirname}`);
      console.error(`Absolute source path: ${path.resolve(SOURCE_DIR)}`);
      
      // Try to list parent directories to help debug
      const parentDir = path.join(__dirname, '..', '..', '..');
      console.error(`Contents of parent directory (${parentDir}):`);
      try {
        const parentContents = fs.readdirSync(parentDir);
        console.error(parentContents.join('\n'));
        
        const templateDir = path.join(parentDir, 'template_generators');
        if (fs.existsSync(templateDir)) {
          console.error(`Contents of template_generators directory:`);
          console.error(fs.readdirSync(templateDir).join('\n'));
        }
      } catch (err) {
        console.error(`Error listing parent directory: ${err.message}`);
      }
      
      process.exit(1);
    }

    // Verify src directory exists in source
    const srcDir = path.join(SOURCE_DIR, 'src');
    if (!fs.existsSync(srcDir)) {
      console.error(`Source src directory not found: ${srcDir}`);
      process.exit(1);
    }

    // Remove destination directory if it exists
    if (fs.existsSync(DEST_DIR)) {
      console.log('Removing existing destination directory...');
      fs.rmSync(DEST_DIR, { recursive: true, force: true });
    }

    // Copy the directory
    copyDirectory(SOURCE_DIR, DEST_DIR);

    // Verify the copy was successful
    if (!fs.existsSync(path.join(DEST_DIR, 'src', 'index.js'))) {
      console.error('Error: index.js file was not copied correctly');
      process.exit(1);
    }

    // Install dependencies in the copied directory
    console.log('Installing dependencies in the copied directory...');
    try {
      execSync('npm install --production', { 
        cwd: DEST_DIR, 
        stdio: 'inherit' 
      });
    } catch (error) {
      console.error('Error installing dependencies:', error.message);
      console.error('Continuing with packaging...');
    }

    console.log('Successfully copied kimapp_feature to the VS Code extension!');
  } catch (error) {
    console.error('Error copying kimapp_feature:', error);
    process.exit(1);
  }
}

// Run the script
main();
