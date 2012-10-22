Audy
================

Deploying Audy with Meteor on Heroku. Live jam sessions.


Initial Steps
-------------

# Install meteor and create the project
    curl https://install.meteor.com | /bin/sh
    meteor create Audy
    cd Audy
    meteor add bootstrap coffeescript underscore jquery backbone accounts-base accounts-ui accounts-password

    # When ready to deploy
    # meteor remove insecure
    # meteor remove autopublish

    git init
    git add .
    git commit -m 'Init'


# For github, either from command line or web interface

    curl -u 'USER:PASS' https://api.github.com/user/repos -d '{"name":"REPO"}'
    git remote add origin git@github.com:USER/REPO.git
    git push origin master


# Requires mongohq, make sure account is verified by adding CC 

    # heroku addons:add mongohq:free

    heroku create audy --stack cedar --buildpack https://github.com/jordansissel/heroku-buildpack-meteor.git
    #heroku config:set ROOT_URL=http://audy.herokuapp.com

    # To deploy just commit and push
    # git commit -m "commit details"
    # git push heroku master


# Caveats
1. Tests have to go into the tests folder, part of the magic


2.  Since a canonical layout is unknown, try using this layout structure

    ## https://github.com/tmeasday/unofficial-meteor-faq#where-should-i-put-my-files
    lib/                    # <- any common code for client/server. 
    lib/environment.js      # <- general configuration
    lib/methods.js          # <- Meteor.method definitions
    lib/external            # <- common code from someone else
    ## Note that js files in lib folders are loaded before other js files.

    collections/                 # <- definitions of collections and methods on them (could be models/)

    client/lib              # <- client specific libraries (also loaded first)
    client/lib/environment.js   # <- configuration of any client side packages
    client/lib/helpers      # <- any helpers (handlebars or otherwise) that are used often in view files

    client/application.js   # <- subscriptions, basic Meteor.startup code.
    client/index.html       # <- toplevel html
    client/index.js         # <- and its JS
    client/views/<page>.html  # <- the templates specific to a single page
    client/views/<page>.js    # <- and the JS to hook it up
    client/views/<type>/    # <- if you find you have a lot of views of the same object type

    server/publications.js  # <- Meteor.publish definitions
    server/lib/environment.js   # <- configuration of server side packages


3. File storage is handled by filepicker.io going to an S3 bucket

  1. Open an AWS account and setup a bucket in S3
    - Under Properties, click Add bucket policy, make sure name is only lowercase

    {
      "Version": "2008-10-17",
      "Statement": [
        {
          "Sid": "Stmt13503376278__",
          "Effect": "Allow",
          "Principal": {
            "AWS": "*"
          },
          "Action": [
            "s3:DeleteObject",
            "s3:GetObject",
            "s3:PutObject"
          ],
          "Resource": "arn:aws:s3:::audy.filepickerio/*"
        }
      ]
    }

  2. In filepicker.io settings add AWS Access Key ID, Secret Access Key
  and bucket name of audy.filepickerio
    - Also set the App arl to your domain

4. Unit testing isn't clear

