export const API_URL = 'http://192.168.99.113.xip.io';
console.log(process.env);

if (!API_URL) {
  console.error('Set `API_URL` in `app/js/actions/index.js` to your deployed endpoint');
}
