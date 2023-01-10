const { environment } = require('@rails/webpacker')

// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');
module.exports = environment

const WebpackerPwa = require('webpacker-pwa');
new WebpackerPwa(config, environment);
