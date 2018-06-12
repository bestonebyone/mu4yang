---
layout: post
category: notes
title: Refine my thought of crude framework
---
[comment]: <> (Below is MathJax)

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>

[comment]: <> (Below are some tips on markdown)

<!---
Code highlight

<head>
    <title>Rouge</title>
    <link media="all" rel="stylesheet" href="/css/rouge.css" />
</head>

<body>
    {% highlight ruby %}
	Code Here
    {% endhighlight %}
</body>

Link

[title](link)

Or

<a href="link" title="title"> Words with link</a>. 

Image

<img src="link" />

Equation

$$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$$
\\(x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}\\)

Superscript and subscript

<sup>superscript</sup>
<sub>subscript</sub>
-->

[comment]: <> (Below are essay)

## Framework overview

The proposed framework has so many place confuse me. I am not sure it is reasonable. So I try to ask myself some questions and make myself understand the framework well.

[The link of proposed pipline is here.]("\notes\img\2018-06-11-A new framework of hand pose estimation.md")

## Question and Answer

1.  
    * Q: Why not estimate the pose through the cross-modal VAE network?
    * A: The original two-VAE network is based on many to many mapping, which means the network can not get accurate pose from occluded image. Even after I change the network to many to one mapping, we can just get image from pose with viewpoint. In fact, how to get all possible pose from one image is the core problem I want to solve.

2. 
    * Q: Why not use ground truth pose of occluded image to get multi-labels at first?
    * A: If we want to use the ground truth to generate all possible pose, we should define a criteria. With this criteria, we can find all the pose with same image (or heatmap projected in one picture). The changed cross-modal VAE network is doing this work actually. So, I think this idea is feasible and will make the work end to end network. But at first, the framework with definite part will make me understand the network well.