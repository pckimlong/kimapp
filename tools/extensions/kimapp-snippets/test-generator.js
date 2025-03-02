#!/usr/bin/env node

/**
 * This script tests if the kimapp_feature generator can be loaded correctly.
 * Run this after packaging the extension to verify that the generator is working.
 */

const fs = require('fs');
const path = require('path');

// Path to the kimapp_feature generator
const generatorPath = path.join(__dirname, 'src', 'kimapp_feature', 'src', 'index.js');

console.log(`Testing kimapp_feature generator at: ${generatorPath}`);

// Check if the file exists
if (!fs.existsSync(generatorPath)) {
  console.error(`ERROR: Generator file not found at: ${generatorPath}`);
  
  // Check if the src directory exists
  const srcDir = path.join(__dirname, 'src');
  if (!fs.existsSync(srcDir)) {
    console.error(`ERROR: src directory not found at: ${srcDir}`);
  } else {
    console.log(`src directory exists at: ${srcDir}`);
    
    // List contents of src directory
    const srcContents = fs.readdirSync(srcDir);
    console.log(`Contents of src directory: ${srcContents.join(', ')}`);
    
    // Check if kimapp_feature directory exists
    const kimappFeatureDir = path.join(srcDir, 'kimapp_feature');
    if (!fs.existsSync(kimappFeatureDir)) {
      console.error(`ERROR: kimapp_feature directory not found at: ${kimappFeatureDir}`);
    } else {
      console.log(`kimapp_feature directory exists at: ${kimappFeatureDir}`);
      
      // List contents of kimapp_feature directory
      const kimappFeatureContents = fs.readdirSync(kimappFeatureDir);
      console.log(`Contents of kimapp_feature directory: ${kimappFeatureContents.join(', ')}`);
      
      // Check if src directory exists in kimapp_feature
      const kimappFeatureSrcDir = path.join(kimappFeatureDir, 'src');
      if (!fs.existsSync(kimappFeatureSrcDir)) {
        console.error(`ERROR: src directory not found in kimapp_feature at: ${kimappFeatureSrcDir}`);
      } else {
        console.log(`src directory exists in kimapp_feature at: ${kimappFeatureSrcDir}`);
        
        // List contents of kimapp_feature/src directory
        const kimappFeatureSrcContents = fs.readdirSync(kimappFeatureSrcDir);
        console.log(`Contents of kimapp_feature/src directory: ${kimappFeatureSrcContents.join(', ')}`);
      }
    }
  }
  
  process.exit(1);
}

// Try to load the generator
try {
  const generator = require(generatorPath);
  console.log('SUCCESS: Generator loaded successfully!');
  
  // Check if the generateFeature function exists
  if (typeof generator.generateFeature === 'function') {
    console.log('SUCCESS: generateFeature function found!');
  } else {
    console.error('ERROR: generateFeature function not found in the generator module');
    process.exit(1);
  }
} catch (error) {
  console.error('ERROR: Failed to load generator:', error);
  process.exit(1);
}

console.log('All tests passed! The kimapp_feature generator is working correctly.'); 