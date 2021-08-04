---
title: "SemiHand"
collection: project
type: "Tutorial"
permalink: /project/SemiHand
---

# SemiHand: Semi-supervised Hand Pose Estimation with Consistency



## Abstract

We present SemiHand, a semi-supervised framework for 3D hand pose
estimation from monocular images. We pre-train the model on labelled synthetic data and fine-tune it on unlabelled real-world data by pseudo-labeling with consistency training. 
By design, we introduce data augmentation of differing difficulties, consistency regularizer, label correction and sample selection for RGB-based 3D hand pose estimation.
In particular, by approximating the hand masks from hand poses, we propose cross-modal consistency to leverage semantic predictions to provide guidance for the predicted poses. Meanwhile, we introduce pose registration as label correction to guarantee the biomechanical feasibility of hand bone lengths. Experiments show that our method achieves a favorable improvement on real-world datasets after fine-tuning.



## Pipeline

![avatar](https://www.mu4yang.com/files/project/semihand/pipeline.jpg)

