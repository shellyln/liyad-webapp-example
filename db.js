

function query(q) {
    return (new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve('this is queried data.')
        }, 30);
    }));
}

exports.query = query;
