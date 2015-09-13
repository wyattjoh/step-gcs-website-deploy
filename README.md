# Deploy to Google Cloud Storage as Website

A step that deploys website to Google Cloud Storage.

It requires a `.boto` config file on the root of the repository,
and requires `gs_oauth2_refresh_token` and `default_project_id` lines in `.boto` like below:

    [Credentials]
    gs_oauth2_refresh_token =
    [GSUtil]
    default_project_id =

see: https://cloud.google.com/storage/docs/gsutil/commands/config

It applies gzip content-encoding to file uploads with below extensions.

  * css
  * html
  * js
  * json
  * map
  * svg
  * txt
  * xml

## Options

### required

* `bucket` - A bucket name of the Google Cloud Storage.
* `project` - A project ID of the Google Cloud Platform.
* `token` - The OAuth 2.0 refresh token of the Google account to use for deployment.

### options

* `dir` - A path to directory that is root of the website. The default value is `public`.

### initialize options

* `initialize` - A flag for initialize a bucket of the Google Cloud Storage via `gsutil mb` command. Not empty is True.
* `class` - A bucket storage class of the Google Cloud Storage.
* `location` - A bucket location of the Google Cloud Storage.

see: https://cloud.google.com/storage/docs/gsutil/commands/mb#bucket-locations

It will be created with the default (Standard) storage class.
It will be set the MainPageSuffix property to `index.html` and the NotFoundPage property to `404.html`.

## Example

```
deploy:
  steps:
  - michilu/gcs-website-deploy:
    bucket:   example.com
    project:  $GOOGLE_PROJECT_ID
    token:    $GOOGLE_REFRESH_TOKEN

    # options
    dir:      public

    # if you want to initialize a bucket
    initialize: not_empty
    class:      DURABLE_REDUCED_AVAILABILITY
    location:   ASIA-EAST1
```
