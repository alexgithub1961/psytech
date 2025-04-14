// Simple test function for Netlify
exports.handler = async function(event, context) {
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Hello from Netlify Functions!",
      timestamp: new Date().toISOString()
    })
  };
};