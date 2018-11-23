

const parseArgs = require('liyad-cli').parseArgs;
const cliCore = require('liyad-cli').cliCore;

console.dir(require('liyad-cli'));
cliCore(parseArgs(['-p', 'LSX_async', '--lsx-boot', 'lsxboot.js', 'app.lisp']));
