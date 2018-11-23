
const fs = require('fs');
const parseArgs = require('liyad-cli').parseArgs;
const cliCore = require('liyad-cli').cliCore;

console.dir(require('liyad-cli'));
cliCore(fs.realpathSync(process.cwd()), parseArgs(['-p', 'LSX_async', '--lsx-boot', 'lsxboot.js', 'app.lisp']));
