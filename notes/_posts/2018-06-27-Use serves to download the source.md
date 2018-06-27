---
layout: post
category: notes
title: Use serves to download the source

## download google drive docs

Download a large file from Google Drive.
If you use curl/wget, it fails with a large file because of the security warning from Google Drive.

- pip install gdown
- gdown https://drive.google.com/uc?id={Docs ID Here}
- The id of file can be found from the share link. For example, a google share link is https://drive.google.com/open?id= **1y5JrOd86NGHTPZLYLgeqRJzT2T4ACWJe**
- ps it seems that the download procedure will quit if the connect is bad. So I am wondering if it has the function that resume from break point.