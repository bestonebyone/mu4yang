---
layout: post
category: notes
title: Aim to solve many to many problem
---

## tensorflow study

- how to set parameters reuse
- if we need to separate the train or not train parameters 
- var_list


## Problem description
According CrossVAE, we know that it is reasonable to have shared latent space. However, one pose can project to many hand image and one image can project to many pose. So I think pose and image should be many to many problem. If we treat it as one to one mapping. We can just get one average estimation. So in fact, this could be described as below. They have not only intersection part but also separate part.
<img src="\notes\img\2018-06-14-1.png" width="80%" align="middle" />

So here, inspired by localized GANs, I come up an idea. maybe the separate part can be get from noise.
<img src="\notes\img\2018-06-28-1.png" width="50%" align="middle" />

At last, there is one problem. If there are two constraints on the latent space, it may not work. So I must make sure that. The first step I decide is pose to pose with this new constraints.

This idea may be considerd as conditional VAE.

**My first purpose is a better random walk between two hand pose. We can find different way to get one pose to another pose. And all the way is plausiable.**