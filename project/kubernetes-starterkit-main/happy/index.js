'use strict';

const Hapi = require('hapi');

const init = async () => {

    const server = Hapi.server({
        port: 4000,
        routes: {cors: { origin: ['*']} },
        host: '0.0.0.0'
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {

            return 'Hello World!';
        }
    });
    server.route({
        method: 'GET',
        path: '/api/happy/{name}',
        handler: (request, h) => {
            return 'Hello, ' + encodeURIComponent(request.params.name) + '!';
        }
    });

    server.route({  
      method: 'GET',
      path: '/multiply',
      handler: (request, h) => {
        const params = request.query
        const result = params.num1 * params.num2;
        //postToBootStorage(params.num1, params.num2, '*',result);
        return result;
      }

    });
    
    server.route({  
      method: 'GET',
      path: '/divide',
      handler: (request, h) => {
        const params = request.query
        const result = params.num1 / params.num2;
        //postToBootStorage(params.num1, params.num2, '/',result);
        return result;
      }
    });
    await server.start();
    console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

init();