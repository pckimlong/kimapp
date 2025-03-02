const { generateListProviderFile } = require('./list');
const { generateDetailProviderFile } = require('./detail');
const { generateCreateProviderFile } = require('./create');
const { generateUpdateProviderFile } = require('./update');
const { generateDeleteProviderFile } = require('./delete');
const { generateListPaginationProviderFile } = require('./list_pagination');

module.exports = {
  generateListProviderFile,
  generateDetailProviderFile,
  generateCreateProviderFile,
  generateUpdateProviderFile,
  generateDeleteProviderFile,
  generateListPaginationProviderFile,
}; 