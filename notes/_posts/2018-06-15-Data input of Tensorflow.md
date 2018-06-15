---
layout: post
category: notes
title: Data input of Tensorflow
---

## Tensorflow input

### 1.Use python to convert dataset into binary files(BinaryDBcreater)

import pickle  
import os  
import scipy.misc  
import struct  

* pickle 是python中, 压缩/保存/提取 文件的模块
* os 文件操作 os.mkdir os.path.exists
* scipy 算法库和数学工具包 scipy.misc 图像处理
* struct - This module performs conversions between Python values and C structs represented as Python strings. - 将python数据类型与其他平台或语言(c语言)之间的类型进行互相转换问题
    * struct.pack用于将Python的值根据格式符，转换为字节流(或字节数组）。其函数原型为：struct.pack(fmt, v1, v2, ...)，参数fmt是格式字符串
    * struct.unpack做的工作刚好与struct.pack相反，用于将字节流转换成python数据类型。它的函数原型为：struct.unpack(fmt, string)，该函数返回一个元组。
    * struct.calcsize(fmt) 计算按照格式 fmt 打包的结果有多少个字节
    * fmt
        * B unsigned char(c) integer(python) 1(Standard size)
        * f float(c) float(python) 4(Standard size)

### 2.BinaryDBReader
* record_bytes - calculate size of each record - this is very important, we must know the accurate position of each data
* reader = tf.FixedLengthRecordReader(header_bytes=0, record_bytes=record_bytes)
*  _, value = reader.read(tf.train.string_input_producer([path_to_db]))
* tf.decode_raw only for one type. So if the data is in different type, should use it for several times.
*  tf.reshape tf.slice tf.cast