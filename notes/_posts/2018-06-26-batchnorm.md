---
layout: post
category: notes
title: batchnorm
---

## batchnorm

tf在进行批处理时，会需要用到均值与方差数据，而在批处理中使用的均值与方差不是单纯的使用当前批数据的均值与方差，而是对会根据当前批均值方差和上一批维护的均值方差进行指数衰减求一个新的均值方差，而对slim中的batch_norm，需要注意以下几点：
slim batch_norm函数的输入参数中有一个decay，该参数能够衡量使用指数衰减函数更新均值方差时，更新的速度，取值通常在0.999-0.99-0.9之间，值越小，代表更新速度越快，而值太大的话，有可能会导致均值方差更新太慢，而最后变成一个常量1，而这个值会导致模型性能较低很多.另外，如果出现过拟合时，也可以考虑增加均值和方差的更新速度，也就是减小decay

updates_collections参数，该参数有一个默认值，ops.GraphKeys.UPDATE_OPS，当取默认值时，slim会在当前批训练完成后再更新均值和方差，这样会存在一个问题，就是当前批数据使用的均值和方差总是慢一拍，最后导致训练出来的模型性能较差。所以，一般需要将该值设为None，这样slim进行批处理时，会对均值和方差进行即时更新，批处理使用的就是最新的均值和方差。

另外，不论是即使更新还是一步训练后再对所有均值方差一起更新，对测试数据是没有影响的，即测试数据使用的都是保存的模型中的均值方差数据，但是如果你在训练中需要测试，而忘了将is_training这个值改成false，那么这批测试数据将会综合当前批数据的均值方差和训练数据的均值方差。而这样做应该是不正确的。

TensorFlow中维护的集合列表，在一个计算图中，可以通过集合(collection)来管理不同类别的资源。比如通过 tf.add_to_collection 函数可以将资源加入一个 或多个集合中，然后通过 tf.get_collection 获取一个集合里面的所有资源(如张量，变量，或者运行TensorFlow程序所需的队列资源等等)

集合名称|集合内容|使用场景
- | :-: | -: 
tf.GraphKeys.VARIABLES|	所有变量|	持久化 TensorFlow 模型
tf.GraphKeys.TRAINABLE_VARIABLES|	可学习的变量(一般指神经网络中的参数)|模型训练、生成模型可视化内容
tf.GraphKeys.SUMMARIES|日志生成相关的张量|TensorFlow 计算可视化
tf.GraphKeys.QUEUE_RUNNERS|处理输入的 QueueRunner|输入处理
tf.GraphKeys.MOVING_AVERAGE_VARIABLES|所有计算了滑动平均值的变量|计算变量的滑动平均值


- TensorFlow中的所有变量都会被自动加入tf.GraphKeys.VARIABLES集合中，通过 tf.global_variables()函数可以拿到当前计算图上的所有变量。拿到计算图上的所有变量有助于持久化整个计算图的运行状态。
- 当构建机器学习模型时，比如神经网络，可以通过变量声明函数中的trainable参数来区分需要优化的参数(比如神经网络的参数)和其他参数(比如迭代的轮数，即超参数)，若trainable = True，则此变量会被加入tf.GraphKeys.TRAINABLE_VARIABLES集合。然后通过 tf.trainable_variables函数便可得到所有需要优化的参数。TensorFlow中提供的优化算法会将tf.GraphKeys.TRAINABLE_VARIABLES集合中的变量作为 默认的优化对象。
- 变量的类型是不可以改变的。
- 变量的维度一般是不能改变的，除非设置参数validate_shape = False(很少去改变它)