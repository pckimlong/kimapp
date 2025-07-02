#!/usr/bin/env node

const { generateFeature } = require('./src/index.js');

// Parse command line arguments
function parseArgs() {
  const args = process.argv.slice(2);
  const options = {};
  
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    
    switch (arg) {
      case '--name':
        options.name = args[++i];
        break;
      case '--id-data-type':
        options.idDataType = args[++i];
        break;
      case '--output-dir':
        options.outputDir = args[++i];
        break;
      case '--generate-ui':
        options.generateUI = true;
        break;
      default:
        console.warn(`Unknown argument: ${arg}`);
    }
  }
  
  return options;
}

// Main function
async function main() {
  try {
    const options = parseArgs();
    
    // Validate required arguments
    if (!options.name) {
      console.error('Error: --name argument is required');
      process.exit(1);
    }
    
    if (!options.idDataType) {
      console.error('Error: --id-data-type argument is required');
      process.exit(1);
    }
    
    if (!options.outputDir) {
      console.error('Error: --output-dir argument is required');
      process.exit(1);
    }
    
    console.log(`Generating kimapp feature: ${options.name}`);
    console.log(`ID Data Type: ${options.idDataType}`);
    console.log(`Output Directory: ${options.outputDir}`);
    console.log(`Generate UI: ${options.generateUI || false}`);
    
    const success = await generateFeature(options);
    
    if (success) {
      console.log('✓ Feature generated successfully!');
      process.exit(0);
    } else {
      console.error('✗ Feature generation failed!');
      process.exit(1);
    }
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

main();