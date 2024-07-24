const { environment } = require('@rails/webpacker')

// Add the necessary loaders
const cssLoader = environment.loaders.get('css')
cssLoader.use.splice(-1, 0, { loader: 'style-loader' })

const fileLoader = environment.loaders.get('file')
fileLoader.use.splice(-1, 0, { loader: 'file-loader' })

module.exports = environment
