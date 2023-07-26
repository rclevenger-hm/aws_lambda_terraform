const AWS = require('aws-sdk');

const comprehend = new AWS.Comprehend();

module.exports.analyzeSentiment = async (event) => {
  try {
    const { text } = JSON.parse(event.body);

    const params = {
      LanguageCode: 'en', // Adjust the language code as per your requirements
      Text: text,
    };

    const result = await comprehend.detectSentiment(params).promise();

    return {
      statusCode: 200,
      body: JSON.stringify(result.Sentiment),
    };
  } catch (error) {
    console.error('Error analyzing sentiment:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Failed to analyze sentiment' }),
    };
  }
};
