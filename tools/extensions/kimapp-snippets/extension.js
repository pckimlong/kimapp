const vscode = require('vscode');
const fs = require('fs');
const path = require('path');

// Import the kimapp_feature generator
let kimappFeatureGenerator;
try {
    const kimappFeaturePath = path.join(__dirname, 'src', 'kimapp_feature', 'src', 'index.js');
    
    // Check if the file exists before requiring it
    if (!fs.existsSync(kimappFeaturePath)) {
        console.error(`Kimapp feature generator file not found at: ${kimappFeaturePath}`);
        throw new Error(`File not found: ${kimappFeaturePath}`);
    }
    
    kimappFeatureGenerator = require(kimappFeaturePath);
    console.log('Successfully loaded kimapp_feature generator');
} catch (error) {
    console.error('Failed to load kimapp_feature generator:', error);
}

/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {
    console.log('Kimapp Snippets extension is now active!');

    let disposable = vscode.commands.registerCommand('kimapp-snippets.createFeature', async function (uri) {
        if (!uri) {
            vscode.window.showErrorMessage('Please right-click on a folder to create a feature.');
            return;
        }

        if (!kimappFeatureGenerator) {
            const errorMessage = 'Kimapp feature generator not available. The extension may not be installed correctly.';
            console.error(errorMessage);
            vscode.window.showErrorMessage(errorMessage + ' Please reinstall the extension or check the logs for more details.');
            return;
        }

        const targetDir = uri.fsPath;

        // Get feature name
        const featureName = await vscode.window.showInputBox({
            prompt: 'What is your feature object\'s name in singular?',
            placeHolder: 'e.g. product, user, order',
            validateInput: (value) => {
                if (!value) return 'Feature name is required';
                if (!/^[a-z][a-z0-9_]*$/.test(value)) {
                    return 'Feature name must be in snake_case (lowercase with underscores)';
                }
                return null;
            }
        });

        if (!featureName) return; // User cancelled

        // Get ID data type
        const idDataType = await vscode.window.showQuickPick(
            ['int', 'String'],
            {
                placeHolder: 'What is the data type of object\'s ID?',
                canPickMany: false
            }
        );

        if (!idDataType) return; // User cancelled

        try {
            // Use the bundled code generator
            const success = await kimappFeatureGenerator.generateFeature({
                name: featureName,
                idDataType: idDataType,
                generateUI: false,
                outputDir: targetDir
            });
            
            if (success) {
                vscode.window.showInformationMessage(`Feature '${featureName}' created successfully!`);
            } else {
                vscode.window.showErrorMessage(`Error creating feature '${featureName}'.`);
            }
        } catch (error) {
            console.error('Error creating feature:', error);
            vscode.window.showErrorMessage(`Error creating feature: ${error.message}`);
        }
    });

    context.subscriptions.push(disposable);
}

function deactivate() {}

module.exports = {
    activate,
    deactivate
}; 