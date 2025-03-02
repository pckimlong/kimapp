const vscode = require('vscode');
const fs = require('fs');
const path = require('path');

// Import the kimapp_feature generator
let kimappFeatureGenerator;
try {
    kimappFeatureGenerator = require('./src/kimapp_feature/src/index.js');
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
            vscode.window.showErrorMessage('Kimapp feature generator not available');
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