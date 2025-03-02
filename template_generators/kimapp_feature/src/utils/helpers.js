/**
 * Convert a snake_case string to PascalCase
 * @param {string} str - The string to convert
 * @returns {string} - The converted string
 */
function toPascalCase(str) {
  return str.split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join('');
}

/**
 * Convert a snake_case string to camelCase
 * @param {string} str - The string to convert
 * @returns {string} - The converted string
 */
function toCamelCase(str) {
  const words = str.split('_');
  return words[0] + words.slice(1)
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join('');
}

module.exports = {
  toPascalCase,
  toCamelCase,
}; 