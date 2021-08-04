---
title: "SemiHand: Semi-supervised Hand Pose Estimation with Consistency"
collection: project
type: "Tutorial"
permalink: /project/SemiHand
---

<div align='center' ><h2>Abstract</h2></div>

We present SemiHand, a semi-supervised framework for 3D hand pose
estimation from monocular images. We pre-train the model on labelled synthetic data and fine-tune it on unlabelled real-world data by pseudo-labeling with consistency training. 
By design, we introduce data augmentation of differing difficulties, consistency regularizer, label correction and sample selection for RGB-based 3D hand pose estimation.
In particular, by approximating the hand masks from hand poses, we propose cross-modal consistency to leverage semantic predictions to provide guidance for the predicted poses. Meanwhile, we introduce pose registration as label correction to guarantee the biomechanical feasibility of hand bone lengths. Experiments show that our method achieves a favorable improvement on real-world datasets after fine-tuning.



<div align='center' ><h2>Pipeline</h2></div>

<center>    <img style="border-radius: 0.3125em;    box-shadow: 0 2px 4px 0 rgba(34,36,38,.12),0 2px 10px 0 rgba(34,36,38,.08);"     src="https://www.mu4yang.com/files/project/semihand/pipeline.jpg">    <br>    <div style="color:orange; border-bottom: 1px solid #d9d9d9;    display: inline-block;    color: #999;    padding: 2px;"><div align='left' >Overview of SemiHand. The model is pre-trained on labelled synthetic data. Consistency training (orange double headed arrow) on unlabelled real-world data with perturbation augmentations and label correction and sample selection (blue dash-dotted arrow) together with augmentation of differing difficulties.</div></div> </center>

<div align='center' ><h2>Results</h2></div>

<center>    <img style="border-radius: 0.3125em;    box-shadow: 0 2px 4px 0 rgba(34,36,38,.12),0 2px 10px 0 rgba(34,36,38,.08);"     src="https://www.mu4yang.com/files/project/semihand/convergence.png">    <br>    <div style="color:orange; border-bottom: 1px solid #d9d9d9;    display: inline-block;    color: #999;    padding: 2px;"><div align='left' >Gradual convergence from the prediction of pre-trained model to our final prediction.  The arrows indicate the direction anddistance of prediction movement during fine-tuning.  For 10th iteration, the optimization converges because the length of arrows becomealmost zeros. We highlight the differences between our stable predictions and the ground-truth poses with red boxes.</div></div> </center>

