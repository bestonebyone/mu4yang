---
layout: post
category: notes
title: Learning Tensorflow
---

## Metric Learning
I want to find a function to calculate the distance between pose and image. I am wondering if the knowledge of metric learning will be beneficial.

## Tensorflow model save and restore
<head>
    <title>Rouge</title>
    <link media="all" rel="stylesheet" href="/css/rouge.css" />
</head>

<body>
    
    {% highlight python %}
	with tf.Session() as sess:
        # model setup....

        initial_step = 0

        # verify if we don't have a checkpoint saved already
        ckpt = tf.train.get_checkpoint_state(os.path.dirname(__file__))
        if ckpt and ckpt.model_checkpoint_path:
            # Restores from checkpoint
            saver.restore(sess, ckpt.model_checkpoint_path)
            initial_step = int(ckpt.model_checkpoint_path.rsplit('-', 1)[1])

        #actual training loop
        for step in range(initial_step, training_steps):
        # run each train step
    {% endhighlight %}
</body>

## some function of Tensorflow or python

os.makedirs and os.mkdir

tf.layers.batch_normalization()
Tensorflow-slim
Tensorflow Tensorboard