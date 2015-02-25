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
  unless process.env.HUBOT_SQS_QUEUE_URL
    robot.logger.error "Disabling incoming-sqs plugin because HUBOT_SQS_QUEUE_URL is not set."
    return

  sqs = new AWS.SQS { region: process.env.AWS_REGION ? 'us-east-1' }

  receiver = (sqs, queue) ->
    robot.logger.debug "Fetching from #{queue}"
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
          new Command(message.Body, robot).run()
          sqs.deleteMessage {
            QueueUrl: queue
            ReceiptHandle: message.ReceiptHandle
          }, (err, data) ->
            robot.logger.error err if err?
      setTimeout receiver, 50, sqs, queue

  setTimeout receiver, 0, sqs, process.env.HUBOT_SQS_QUEUE_URL

class Command
  constructor: (@body, @robot) ->

  run: ->
    try
      body = JSON.parse @body
      switch body.Command
        when 'SendMessage'
          @robot.send body.Envelope, body.Message
        else
          @robot.logger.error "Unknown command: #{body.Command}"
    catch err
      @robot.logger.error err
