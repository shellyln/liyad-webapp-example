

function query(q) {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            console.error(`this is queried data for query ${q}.`);
            resolve(`this is queried data for query ${q}.`)
        }, 30);
    }));
}
exports.query = query;


function begin() {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            console.error('begin');
            resolve('begin')
        }, 30);
    }));
}
exports.begin = begin;


function commit() {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            console.error('commit');
            resolve('commit')
        }, 30);
    }));
}
exports.commit = commit;


function rollback() {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            console.error('rollback');
            resolve('rollback')
        }, 30);
    }));
}
exports.rollback = rollback;
