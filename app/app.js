const http = require('http');

const port = process.env.PORT || 8080;

function getClientIp(req) {
  const xff = req.headers['x-forwarded-for'];
  if (xff) return xff.split(',')[0].trim();
  const addr = req.socket && req.socket.remoteAddress ? req.socket.remoteAddress : '';
  return addr.replace(/^::ffff:/, '');
}

const server = http.createServer((req, res) => {
  if (req.url === '/' && req.method === 'GET') {
    const payload = {
      timestamp: new Date().toISOString(),
      ip: getClientIp(req),
    };
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(payload));
    return;
  }

  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'not found' }));
});


server.listen(port, '0.0.0.0', () => {
  console.log(`Server running on port ${port}`);
});
