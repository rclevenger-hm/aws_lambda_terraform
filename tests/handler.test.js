const { start } = require('../handler');

describe('Text Sentiment Analysis Lambda Tests', () => {
  it('should return the correct response for positive sentiment', async () => {
    const event = {
      body: JSON.stringify({ text: 'I love this product!' }),
    };
    const expectedResponse = {
      statusCode: 200,
      body: JSON.stringify('POSITIVE'),
    };

    const response = await start(event);
    expect(response).toEqual(expectedResponse);
  });

  it('should return the correct response for neutral sentiment', async () => {
    // Add more test cases for different sentiment scenarios (neutral and negative)
  });
});
