# hubot-incoming-sqs

Hubot incoming queue using SQS

## Description

This hubot script lets you send commands to Hubot via Amazon SQS queue.

## Installation

    > npm install --save hubot-incoming-sqs

## Configuration

### HUBOT_SQS_QUEUE_URL

You have to specify the queue URL to pull commands from.

e.g.: `https://sqs.us-east-1.amazonaws.com/885581794223/hubot-queue`

### AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SQS_REGION

AWS-related environment variables are required to be set correctly, so that the bot can access the queue specified above with HUBOT_SQS_QUEUE_URL.

## Commands

