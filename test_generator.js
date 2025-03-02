const path = require('path');
const fs = require('fs-extra');
const { generateListPaginationProviderFile } = require('./template_generators/kimapp_feature/src/generators/providers/list_pagination');

async function runTest() {
  try {
    // Create a test directory
    const testDir = path.join(__dirname, 'test_output');
    const providersPath = path.join(testDir, 'providers');
    
    // Ensure the directory exists
    await fs.ensureDir(providersPath);
    
    // Test the generator
    console.log('Testing list_pagination generator...');
    await generateListPaginationProviderFile(providersPath, 'test_feature');
    
    // Check if the file was created
    const filePath = path.join(providersPath, 'test_feature_list_pagination_provider.dart');
    const fileExists = await fs.pathExists(filePath);
    
    console.log(`File created: ${fileExists}`);
    if (fileExists) {
      console.log(`File size: ${(await fs.stat(filePath)).size} bytes`);
    }
  } catch (error) {
    console.error('Error running test:', error);
  }
}

runTest(); 