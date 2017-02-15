# Deploy to Google Cloud Storage as Website

A step that deploys website to Google Cloud Storage.

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

## Example

```
deploy:
  steps:
  - wyattjoh/gcs-website-deploy:
    bucket:   example.com
    project:  $GOOGLE_PROJECT_ID
    token:    $GOOGLE_REFRESH_TOKEN

    # options
    dir:      public
```
