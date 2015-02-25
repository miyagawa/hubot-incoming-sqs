# hubot-incoming-sqs

Hubot incoming queue using SQS

## Description

This hubot script lets you send commands to Hubot via Amazon SQS queue.

## Screenshot

![](https://dl.dropboxusercontent.com/u/135035/hubot-sqs.gif)

## Installation

    > npm install --save hubot-incoming-sqs

## Configuration

### HUBOT_SQS_QUEUE_URL

You have to specify the queue URL to pull commands from.

e.g.: `https://sqs.us-east-1.amazonaws.com/885581794223/hubot-queue`

### AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY

AWS-related environment variables are required to be set correctly, so that the bot can access the queue specified above with HUBOT_SQS_QUEUE_URL.

### AWS_REGION

You can configure the region of SQS with AWS_REGION, which defaults to `us-east-1`.

## Commands

The SQS messages needs to have a message body in JSON format.

### SendMessage

```
{
  "Command": "SendMessage",
  "Envelope": {"user":"miyagawa","room":"general"},
  "Message": "Hi!"
}
```

`SendMessage` takes arguments in `Envelope` and `Message` to be send as in:

    robot.send data.Envelope, data.Message

the format of Envelope might be specific to the adapter you're using.


## License

MIT License

## Author

Tatsuhiko Miyagawa

