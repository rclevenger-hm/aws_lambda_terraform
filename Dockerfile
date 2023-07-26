FROM node:14-slim

WORKDIR /app

COPY lambda_function /app/lambda_function

RUN cd /app/lambda_function && \
    npm install --production

ENV HANDLER_FILE="handler.js"
ENV HANDLER_FUNCTION="analyzeSentiment"

ENV AWS_REGION="us-east-1"

EXPOSE 3000

CMD ["node", "/app/lambda_function/${HANDLER_FILE}", "${HANDLER_FUNCTION}"]