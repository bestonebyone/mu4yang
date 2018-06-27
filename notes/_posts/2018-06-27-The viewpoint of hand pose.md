---
layout: post
category: notes
title: The viewpoint of hand pose
---

## The discussion with Professor

Professor come back from cvpr conference and discuss with me this morning.

- At first, I misunderstant the meaning of many to many mapping in the CrossVAE. In the paper, the author means (2d pose, 3d pose, depth, rgb) -> (2d pose, 3d pose, depth, rgb)

- I show my own idea that try to combine Shared latent space with Localized GANs. Localized GANs has a very impressive characteristic that it can generate specific data from one direction. From Fig.2 in Ref.[1], I find that the algorithm generate different angle of one face. So I imagine that maybe I can use this method to get different viewpoint. Professor also agree with this idea. Also, she provide a paper related to viewpoint [2].

- Professor mention that Ref.[3] is also very interesting. It makes the hand pose manifold space more complete.



## Reference
[1] Global versus Localized Generative Adversarial Nets
[2] Stereo Magnification: Learning view synthesis using multiplane images
[3] Augmented Skeleton Space Transfer for Depth-based Hand Pose Estimation