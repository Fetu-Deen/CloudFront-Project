#!/usr/bin/env bash
set -euo pipefail

BUCKET="static-site-server-coderco"
DIST_ID="${DIST_ID:?Set DIST_ID first: export DIST_ID=E...}"

echo "Syncing site/ to s3://$BUCKET ..."
aws s3 sync site/ "s3://$BUCKET" --delete

echo "Invalidating CloudFront cache ..."
aws cloudfront create-invalidation --distribution-id "$DIST_ID" --paths "/*" --no-cli-pager

echo "Done. Live at https://site.fetudeen.com"
