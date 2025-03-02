#!/usr/bin/env node

/**
 * This script tests the kimapp_feature generator by simulating what the extension would do.
 */

const path = require('path');
const fs = require('fs');

// Path to the kimapp_feature generator
const generatorPath = path.join(__dirname, 'src', 'kimapp_feature', 'src', 'index.js');

console.log(`Testing kimapp_feature generator at: ${generatorPath}`);

// Check if the file exists
if (!fs.existsSync(generatorPath)) {
  console.error(`ERROR: Generator file not found at: ${generatorPath}`);
  process.exit(1);
}

// Try to load the generator
try {
  const generator = require(generatorPath);
  console.log('SUCCESS: Generator loaded successfully!');
  
  // Check if the generateFeature function exists
  if (typeof generator.generateFeature !== 'function') {
    console.error('ERROR: generateFeature function not found in the generator module');
    process.exit(1);
  }
  
  // Create a test output directory
  const testOutputDir = path.join(__dirname, 'test_output');
  if (!fs.existsSync(testOutputDir)) {
    fs.mkdirSync(testOutputDir, { recursive: true });
  }
  
  // Generate a test feature
  console.log('Generating test feature...');
  generator.generateFeature({
    name: 'test_feature',
    idDataType: 'int',
    generateUI: false,
    outputDir: testOutputDir
  }).then(success => {
    if (success) {
      console.log('SUCCESS: Test feature generated successfully!');
      
      // Check if the files were created
      const featureDir = path.join(testOutputDir, 'test_feature');
      if (fs.existsSync(featureDir)) {
        console.log('Feature directory created successfully.');
        
        // List the files in the feature directory
        const files = fs.readdirSync(featureDir);
        console.log('Files in the feature directory:');
        console.log(files);
        
        // Check if the providers directory was created
        const providersDir = path.join(featureDir, 'providers');
        if (fs.existsSync(providersDir)) {
          console.log('Providers directory created successfully.');
          
          // List the files in the providers directory
          const providerFiles = fs.readdirSync(providersDir);
          console.log('Files in the providers directory:');
          console.log(providerFiles);
          
          // Check if the list_pagination_provider.dart file was created
          const paginationFile = path.join(providersDir, 'test_feature_list_pagination_provider.dart');
          if (fs.existsSync(paginationFile)) {
            console.log('List pagination provider file created successfully.');
          } else {
            console.error('ERROR: List pagination provider file not created.');
          }
        } else {
          console.error('ERROR: Providers directory not created.');
        }
      } else {
        console.error('ERROR: Feature directory not created.');
      }
    } else {
      console.error('ERROR: Failed to generate test feature.');
    }
  }).catch(error => {
    console.error('ERROR: Exception while generating test feature:', error);
  });
} catch (error) {
  console.error('ERROR: Failed to load generator:', error);
  process.exit(1);
} 