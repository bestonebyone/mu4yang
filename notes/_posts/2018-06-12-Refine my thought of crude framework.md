---
layout: post
category: notes
title: Refine my thought of crude framework
---

## Framework overview

The proposed framework has so many place confuse me. I am not sure it is reasonable. So I try to ask myself some questions and make myself understand the framework well.

<a href="/notes/2018/06/11/A-new-framework-of-hand-pose-estimation"> The link of proposed pipline is here.</a>. 
## Question and Answer

1.  
    * Q: Why not estimate the pose through the cross-modal VAE network?
    * A: The original two-VAE network is based on many to many mapping, which means the network can not get accurate pose from occluded image. Even after I change the network to many to one mapping, we can just get image from pose with viewpoint. In fact, how to get all possible pose from one image is the core problem I want to solve.

2. 
    * Q: Why not use ground truth pose of occluded image to get multi-labels at first?
    * A: If we want to use the ground truth to generate all possible pose, we should define a criteria. With this criteria, we can find all the pose with same image (or heatmap projected in one picture). The changed cross-modal VAE network is doing this work actually. So, I think this idea is feasible and will make the work end to end network. But at first, the framework with definite part will make me understand the network well.

---

## Daily Code Study
1. tf.nn.conv2d & tf.layers.conv2d
    *   * x = tf.layers.conv2d(x, filters=64, kernel_size=4, strides=2, padding='same', activation=activation)
        * filters: Integer, the dimensionality of the output space (i.e. the number of filters in the convolution).
    *   * input = tf.Variable(tf.random_normal([1,3,3,5]))  
        * filter = tf.Variable(tf.random_normal([1,1,5,1]))  
        * op = tf.nn.conv2d(input, filter, strides=[1, 1, 1, 1], padding='VALID')
        * filter: A Tensor. Must have the same type as input. A 4-D tensor of shape [filter_height, filter_width, in_channels, out_channels]
2. Today I try to write two VAE with shared latent space.
    * The namespace and the function of reuse
    * The input and output of tf.nn or tf.layer confuse me
    * tf.cond & tf.where
    * list array problem
        * flag:[rd.randint(0, 1), rd.randint(0, 1)] is right
        * flag = [rd.randint(0, 1), rd.randint(0, 1)]; flag:flag is wrong
        * batch_resize = batch[:,4:24,4:24] is wrong
        * batch_resize = np.array(batch); batch_resize = batch_resize[:,4:24,4:24] is right