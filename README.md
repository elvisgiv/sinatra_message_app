# sinatra_message_app

Build a web application which creates a text self-destructing

messages.

User opens website and creates a message. Application generates a

safe link to this saved message (like:

http://yourapp.com/message/ftr45e32fgv56d2).

User should be able to choose destruction option:

● destroy message after the first link visit

● destroy after 1 hour

All the messages stored on the server side should be encrypted using

AES algorithm (you can use any library for text encryption).