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


## 压缩分卷和解压

linux 下的解压缩、分卷、加密

一、linux下的压缩和解压缩命令
1）tar指令压缩
下面的列表中显示了tar指令的纤细参数，其实主要的几个参数也就那么几个，使用tar指令可以直接分卷（不过这个分卷没有直接用过）
tar czvf file.tgz file/   //讲目录或者文件file压缩为file.tgz
tar czvfp - file.tar.gz | split -b 5m     //压缩好的文件再分卷
cat x* > file.tgz  //合并刚才分卷的文件 合并后的文件为file.tgz
 .tar
　　解包：tar zxvf FileName.tar
　　打包：tar czvf FileName.tar DirName
tar -cf all.tar *.jpg
这条命令是将所有.jpg的文件打成一个名为all.tar的包。-c是表示产生新的包，-f指定包的文件名。
tar -rf all.tar *.gif
这条命令是将所有.gif的文件增加到all.tar的包里面去。-r是表示增加文件的意思。
tar -uf all.tar logo.gif
这条命令是更新原来tar包all.tar中logo.gif文件，-u是表示更新文件的意思。
tar -tf all.tar
这条命令是列出all.tar包中所有文件，-t是列出文件的意思
tar -xf all.tar
这条命令是解出all.tar包中所有文件，-t是解开的意思
压缩
tar –cvf jpg.tar *.jpg //将目录里所有jpg文件打包成tar.jpg
tar –czf jpg.tar.gz *.jpg //将目录里所有jpg文件打包成jpg.tar后，并且将其用gzip压缩，生成一个gzip压缩过的包，命名为jpg.tar.gz
tar –cjf jpg.tar.bz2 *.jpg //将目录里所有jpg文件打包成jpg.tar后，并且将其用bzip2压缩，生成一个bzip2压缩过的包，命名为jpg.tar.bz2
tar –cZf jpg.tar.Z *.jpg //将目录里所有jpg文件打包成jpg.tar后，并且将其用compress压缩，生成一个umcompress压缩过的包，命名为jpg.tar.Z
rar a jpg.rar *.jpg //rar格式的压缩，需要先下载rar for linux
zip jpg.zip *.jpg //zip格式的压缩，需要先下载zip for linux
解压
tar –xvf file.tar //解压 tar包
tar -xzvf file.tar.gz //解压tar.gz
tar -xjvf file.tar.bz2 //解压 tar.bz2
tar –xZvf file.tar.Z //解压tar.Z