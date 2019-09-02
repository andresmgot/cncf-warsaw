module.exports = {
  hello: function(event, context) {
    console.log("Received new message! ", event.data);
    return "ok";
  }
};
