---
layout: post
category: notes
excerpt_separator: <!--more-->
title: My new framework of hand pose estimation
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
-->

[comment]: <> (Below are essay)

## Algorithm overview

* RGB image -> all possible poses
* Temporal information -> maximum possible pose

1. Train Cross-modal VAE.
    * \\(Enc_f(image) = z, \quad  Dec_f(z) = image\\)
    * \\(Enc_g(pose,viewpoint) = z,\quad Dec_g(z) = heatmap\\)
2. Define the distance between image and pose with viewpoint.
    * \\(dist(image,pose,viewpoint) = Dec_f(Enc_g(pose,viewpoint)) - Dec_f(Enc_f(image)).\\)
3. Train a traditional 3D pose estimator.
    * \\( keyPose = Estimator(image) \\)
4. Define pose neighbor generator based on viewpoint and joint angle.
    * \\(Neighbors = Generator(keyPose).\\)
5. Set a distance theshold and Calculate the distance between Neighbors and image. If the distance less than the theshold, then this neighbor is a possible solution.
6. Define occlusion model for the occluded hand joint and use all the solution to fit the model parameters.

## Reference

