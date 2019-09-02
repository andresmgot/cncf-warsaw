module.exports = {
  hello: function(event, context) {
    return event.extensions.request.headers;
  }
};
