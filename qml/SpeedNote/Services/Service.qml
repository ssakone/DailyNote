import QtQuick

QtObject {
    id: service

    function fetch(opts) {
        return new Promise(function (resolve, reject) {
            var xhr = new XMLHttpRequest()
            xhr.onload = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status == 200 || xhr.status == 201) {
                        var res = JSON.parse(xhr.responseText.toString())
                        resolve(res)
                    } else {
                        let r = {
                            "status": xhr.status,
                            "statusText": xhr.statusText
                        }
                        reject(r)
                    }
                } else {
                    let r = {
                        "status": xhr.status,
                        "statusText": xhr.statusText
                    }
                    reject(r)
                }
            }
            xhr.onerror = function() {
                let r = {
                    "status": 0,
                    "statusText": 'NO CONNECTION'
                }
                reject(r)
            }

            xhr.open(opts.method ? opts.method : 'GET', opts.url)

            if (opts.headers) {
                Object.keys(opts.headers).forEach(function (key) {
                    xhr.setRequestHeader(key, opts.headers[key])
                })
            }

            let obj = opts.params

            var data = obj ? JSON.stringify(obj) : ''

            xhr.send(data)
        })
    }

    function request(method, route, params) {
        let query = {
            "method": method,
            "url": 'http://localhost:8000/' + route,
            "headers": {
                "Accept": 'application/json',
                "Content-Type": 'application/json'
            },
            "params": params ?? null
        }
        return fetch(query)
    }

    function generateUUID() { // Public Domain/MIT
        var d = new Date().getTime();//Timestamp
        var d2 = ((typeof performance !== 'undefined') && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random() * 16;//random number between 0 and 16
            if(d > 0){//Use timestamp until depleted
                r = (d + r)%16 | 0;
                d = Math.floor(d/16);
            } else {//Use microseconds since page-load if supported
                r = (d2 + r)%16 | 0;
                d2 = Math.floor(d2/16);
            }
            return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
    }

    function checkInternet() {
        return service.fetch({
          "method": "GET",
          "url": 'http://localhost:8000/',
          "headers": {
              "Accept": 'application/json',
              "Content-Type": 'application/json'
          },
          "params": null
          })
    }
}
