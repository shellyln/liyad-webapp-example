

function query(q) {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve(`this is queried data for query ${q}.`)
        }, 30);
    }));
}
exports.query = query;


function begin() {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('begin')
        }, 30);
    }));
}
exports.begin = begin;


function commit() {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('commit')
        }, 30);
    }));
}
exports.commit = commit;


function rollback() {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('rollback')
        }, 30);
    }));
}
exports.rollback = rollback;
