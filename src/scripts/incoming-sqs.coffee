# Description:
#   Hubot incoming queue with SQS
#
# Dependencies:
#   aws-sdk
#
# Author:
#   Tatsuhiko Miyagawa
AWS = require 'aws-sdk'

module.exports = (robot) ->
  sqs = new AWS.SQS { region: process.env.AWS_SQS_REGION ? 'us-east-1' }

  receiver = (sqs, queue) ->
    sqs.receiveMessage {
      QueueUrl: queue
      MaxNumberOfMessages: 10
      VisibilityTimeout: 30
      WaitTimeSeconds: 20
    }, (err, data) ->
      if err?
        robot.logger.error err
      else if data.Messages
        data.Messages.forEach (message) ->
          robot.send { user: "Shell", room: "Shell" }, message.Body
          sqs.deleteMessage {
            QueueUrl: queue
            ReceiptHandle: message.ReceiptHandle
          }, (err, data) ->
            robot.logger.error err if err?
      setTimeout receiver, 200, sqs, queue

  setTimeout receiver, 0, sqs, process.env.HUBOT_SQS_QUEUE_URL
