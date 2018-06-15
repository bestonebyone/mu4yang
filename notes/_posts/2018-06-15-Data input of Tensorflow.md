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


### The input framework of tensorflow

<head>
    <title>python</title>
    <link media="all" rel="stylesheet" href="/css/rouge.css" />
</head>

<body>
    {% highlight python %}
    files_in = ["./data/data_batch%d.bin" % i for i in range(1, 6)]
    files = tf.train.string_input_producer(files_in)
    reader = tf.FixedLengthRecordReader(record_bytes = 1024)
    key, value = reader.read(files)
    data = tf.decode_raw(value, tf.uint8)

    label = tf.cast(tf.slice(data, [0], [1]), tf.int64)
    # tf.slice(inputs, begin, size, name='')
    raw_image = tf.reshape(tf.slice(data, [1], [32*32*3]), [3, 32, 32])
    image = tf.cast(tf.transpose(raw_image, [1, 2, 0]), tf.float32)

    lr_image = tf.image.random_flip_left_right(image)
    br_image = tf.image.random_brightness(lr_image, max_delta=63)
    rc_image = tf.image.random_contrast(br_image, lower=0.2, upper=1.8)

    std_image = tf.image.per_image_standardization(rc_image)
    # 用tf.train.batch或者tf.train.shuffle_batch把一个一个小样本的tensor打包成样本batch，这些函数的输入是单个样本，输出就是4D的样本batch了
    images, labels = tf.train.batch([std_image, label],
                           batch_size=100,
                           num_threads=16,
                           capacity=int(50000* 0.4 + 3 * batch_size))
    # image和label一定要一起run，要记清楚我们的image和label是在一张graph里边的，跑一次那个graph，这两个tensor都会出结果，要是分开跑，出来的图像和标签不对应
    tf.train.start_queue_runners(sess=self.sess)
    # tf.train.start_queue_runners(sess=sess)这一步一定要运行，且其位置要在定义好读取graph之后，在真正run之前，其作用是把queue里边的内容初始化，不跑这句一开始string_input_producer那里就没调用
    real_images, real_labels = sess.run([training_images, training_labels])

    {% endhighlight %}
</body>