const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs-extra');

// Import all generators
const {
  generateSchemaFile,
  generateRepoFile,
  generateListParamFile,
  generateListProviderFile,
  generateDetailProviderFile,
  generateCreateProviderFile,
  generateUpdateProviderFile,
  generateDeleteProviderFile,
  generateListPaginationProviderFile
} = require('./generators');

/**
 * Generate a Kimapp feature
 * @param {Object} options - Feature generation options
 * @param {string} options.name - Feature name in snake_case (e.g. product, user, order)
 * @param {string} options.idDataType - The data type of the ID field (e.g. int, String)
 * @param {boolean} options.generateUI - Whether to generate UI for the feature
 * @param {string} options.outputDir - The directory where the feature should be generated
 * @returns {Promise<boolean>} - Whether the generation was successful
 */
async function generateFeature(options) {
  try {
    const { name, idDataType, generateUI, outputDir } = options;
    
    // Validate inputs
    if (!name || !idDataType || outputDir === undefined) {
      console.error('Missing required parameters');
      return false;
    }
    
    // Create feature directory structure
    const featurePath = path.join(outputDir, name);
    const paramsPath = path.join(featurePath, 'params');
    const providersPath = path.join(featurePath, 'providers');
    
    // Create directories
    await fs.ensureDir(featurePath);
    await fs.ensureDir(paramsPath);
    await fs.ensureDir(providersPath);

    // Generate files
    await generateSchemaFile(featurePath, name, idDataType);
    await generateRepoFile(featurePath, name, idDataType);
    await generateListParamFile(paramsPath, name);
    
    // Generate provider files
    await generateListProviderFile(providersPath, name);
    await generateDetailProviderFile(providersPath, name);
    await generateCreateProviderFile(providersPath, name);
    await generateUpdateProviderFile(providersPath, name);
    await generateDeleteProviderFile(providersPath, name);
    await generateListPaginationProviderFile(providersPath, name);

    // Generate UI if requested
    if (generateUI) {
      await generateFeatureUI(name, outputDir);
    }

    return true;
  } catch (error) {
    console.error('Error generating feature:', error);
    return false;
  }
}

/**
 * Generate UI for a feature using mason
 * @param {string} name - Feature name in snake_case
 * @param {string} outputDir - The directory where the feature should be generated
 * @returns {Promise<boolean>} - Whether the generation was successful
 */
async function generateFeatureUI(name, outputDir) {
  try {
    // Call the mason make command to generate UI
    execSync(`mason make kimapp_feature_ui --name ${name}`, {
      cwd: outputDir,
      stdio: 'inherit',
    });
    return true;
  } catch (error) {
    console.error('UI generation failed:', error);
    return false;
  }
}

module.exports = {
  generateFeature,
}; 