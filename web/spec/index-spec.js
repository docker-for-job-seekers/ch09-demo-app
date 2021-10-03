const request = require('request');
const baseUrl = 'http://localhost:3000';

describe('Checking /health endpoint', () => {
    var server;
    beforeAll(() => {
        server = require('../index.js');
    })
    afterAll(() => {
        server.close();
    })
    it('return status code 200', (done) => {
        request.get(`${baseUrl}/health`, (err, response, body) => {
            expect(response.statusCode).toBe(200);
            done();
        })
    })
})