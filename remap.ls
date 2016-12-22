require! fs: {readFileSync, writeFileSync} \remap-istanbul : remap

map-file = \lib/index.js.map
map = readFileSync map-file .toString!replace \"src/ \"../src/
writeFileSync map-file, map

remap \coverage/coverage.json output =
  json: \coverage/coverage.json
  lcovonly: \coverage/lcov.info
  html: \coverage/lcov-report
