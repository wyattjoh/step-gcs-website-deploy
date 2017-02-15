function install_gcs() {
  debug 'Installing gsutil'
  curl -sO https://storage.googleapis.com/pub/gsutil.tar.gz
  rm -rf $WERCKER_CACHE_DIR/gsutil
  tar xfz gsutil.tar.gz -C $WERCKER_CACHE_DIR
}

export PATH=${PATH}:$WERCKER_CACHE_DIR/gsutil
if ! type gsutil > /dev/null; then
  install_gcs
elif [ `gsutil version|awk '{print $3}'|tr -d "\\r\\n"` != \
     `curl -sI https://storage.googleapis.com/pub/gsutil.tar.gz|grep x-goog-meta-gsutil_version|awk '{print $2}'|tr -d "\\r\\n"` ]; then
  install_gcs
fi

debug 'setting gsutil'

cat > .boto <<EOF
[Credentials]
gs_oauth2_refresh_token = ${WERCKER_GCS_WEBSITE_DEPLOY_TOKEN}

[GSUtil]
default_project_id = ${$WERCKER_GCS_WEBSITE_DEPLOY_PROJECT}
EOF

export BOTO_PATH=$PWD/.boto

debug 'Starting deployment'

# if WERCKER_GCS_WEBSITE_DEPLOY_DIR is empty
[ -z "$WERCKER_GCS_WEBSITE_DEPLOY_DIR" ] && WERCKER_GCS_WEBSITE_DEPLOY_DIR=public

gsutil -m rsync -r -d $WERCKER_GCS_WEBSITE_DEPLOY_DIR gs://$WERCKER_GCS_WEBSITE_DEPLOY_BUCKET
gsutil -m cp -r -z html,css,js,xml,txt,json,map,svg $WERCKER_GCS_WEBSITE_DEPLOY_DIR/* gs://$WERCKER_GCS_WEBSITE_DEPLOY_BUCKET

success 'Finished'
