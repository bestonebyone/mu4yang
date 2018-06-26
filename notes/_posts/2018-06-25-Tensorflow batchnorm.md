---
layout: post
category: notes
title: Tensorflow batchnorm
---

## One mistake of batchnorm

Problem: When the program is in test phase, I set the training = False, and then I just get result nan.

After I google it, I found I misuse the batch norm function. In the website of tensorflow, I found the standard usage of batch norm. It is shown below.

**Note: when training, the moving_mean and moving_variance need to be updated. By default the update ops are placed in tf.GraphKeys.UPDATE_OPS, so they need to be added as a dependency to the train_op.**  
**One can set updates_collections=None to force the updates in place, but that can have a speed penalty, especially in distributed settings.**


<head>
    <title>Rouge</title>
    <link media="all" rel="stylesheet" href="/css/rouge.css" />
</head>

<body>
    {% highlight python %}
	update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS)
    with tf.control_dependencies(update_ops):
        train_op = optimizer.minimize(loss)
    {% endhighlight %}
</body>

Also, I found that batch norm may appear some mistake because of the batch size.

<head>
    <title>Rouge</title>
    <link media="all" rel="stylesheet" href="/css/rouge.css" />
</head>

<body>
    {% highlight python %}
# 控制依赖只对那些在context中建立的操作有效，仅仅在context中使用一个操作或张量是没用的

# WRONG
def my_func(pred, tensor):
  t = tf.matmul(tensor, tensor)
  with tf.control_dependencies([pred]):
    # The matmul op is created outside the context, so no control
    # dependency will be added.
    return t

# RIGHT
def my_func(pred, tensor):
  with tf.control_dependencies([pred]):
    # The matmul op is created in the context, so a control dependency
    # will be added.
    return tf.matmul(tensor, tensor)
    {% endhighlight %}
</body>



这里又出现了一个问题，我是两个网络公用shared latent space，其中一个网络需要batchnorm 另一个不需要，我直接在loss处加这段代码貌似出现了问题，更新的不太对。而我将它只加载batchnorm需要的那个网络那里(这里我通过定义了两个train_op来实现不同的时候训练不同)，则看起来很正常。batchnorm的问题感觉很多，网上出现各种各样的问题。如果还有什么问题可以参考stack overflow的问题How could I use Batch Normalization in TensorFlow?

## batchnorm knowledge from internet

tf在进行批处理时，会需要用到均值与方差数据，而在批处理中使用的均值与方差不是单纯的使用当前批数据的均值与方差，而是对会根据当前批均值方差和上一批维护的均值方差进行指数衰减求一个新的均值方差，而对slim中的batch_norm，需要注意以下几点：
slim batch_norm函数的输入参数中有一个decay，该参数能够衡量使用指数衰减函数更新均值方差时，更新的速度，取值通常在0.999-0.99-0.9之间，值越小，代表更新速度越快，而值太大的话，有可能会导致均值方差更新太慢，而最后变成一个常量1，而这个值会导致模型性能较低很多.另外，如果出现过拟合时，也可以考虑增加均值和方差的更新速度，也就是减小decay

**updates_collections参数，该参数有一个默认值，ops.GraphKeys.UPDATE_OPS，当取默认值时，slim会在当前批训练完成后再更新均值和方差，这样会存在一个问题，就是当前批数据使用的均值和方差总是慢一拍，最后导致训练出来的模型性能较差。所以，一般需要将该值设为None，这样slim进行批处理时，会对均值和方差进行即时更新，批处理使用的就是最新的均值和方差。** --这也许是为什么要用with tf.control_dependencies(update_ops)确保update_ops更新的比较早。

TF可以协调多个数据流，在存在依赖的节点下非常有用，例如节点B要读取模型参数值V更新后的值，而节点A负责更新参数V，所以节点B就要等节点A执行完成后再执行，不然读到的就是更新以前的数据。这时候就需要个运算控制器tf.control_dependencies。tf.control_dependencies()设计是用来控制计算流图的，给图中的某些计算指定顺序。

相似的是 TensorFlow流程控制函数：tf.group。tf.identity()和tf.group()均可将语句变为操作
详细说明

<head>
    <title>Rouge</title>
    <link media="all" rel="stylesheet" href="/css/rouge.css" />
</head>

<body>
x = tf.Variable(0.0)
#返回一个op，表示给变量x加1的操作
x_plus_1 = tf.assign_add(x, 1)
  
#control_dependencies的意义是，在执行with包含的内容（在这里就是 y = x）前
#先执行control_dependencies中的内容（在这里就是 x_plus_1）
with tf.control_dependencies([x_plus_1]):
    y = x
init = tf.initialize_all_variables()
  
with tf.Session() as session:
    init.run()
    for i in xrange(5):
        print(y.eval())
# it prints 0, 0, 0, 0, 0.
# 这是因为此时的y是一个复制了x变量的变量，并未和图上的节点相联系不接受流程控制函数的调遣
# 从tensor的定义说起。tensor可以是Variable，Constant，Placeholder等等。但是，官网上还有一句话值得注意：Unlike tf.Tensor objects, a tf.Variable exists outside the context of a single session.run call.这个说明了variable的特殊性，这也就是 y = x 失效，而 y = tf.identity(x)有效的原因。
# Tensor类应该是最基本最核心的数据结构了，表示的是一个操作的输出，但是他并不接收操作输出的值，而是提供了在TensorFlow的Session中计算这些值的方法。 


import tensorflow as tf
x = tf.Variable(0.0)
print(x)
x_plus_1 = tf.assign_add(x, 1)
with tf.control_dependencies([x_plus_1]):
    y = x + 0.0
    print(y) #z=tf.identity(x,name='x')
init = tf.global_variables_initializer()
with tf.Session() as sess:
    sess.run(init)
    for i in range(5):
        print(sess.run(y))
# it prints 1, 2, 3, 4, 5.
# 这里Variable 变 tensor

x = tf.Variable(0.0)
x_plus_1 = tf.assign_add(x, 1)
  
with tf.control_dependencies([x_plus_1]):
    y = tf.identity(x)#修改部分
init = tf.initialize_all_variables()
  
with tf.Session() as session:
    init.run()
    for i in range(5):
        print(y.eval())
# it prints 1, 2, 3, 4, 5.
# 相当于 y=x 同时 y的类型变成了tensor
</body>

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

