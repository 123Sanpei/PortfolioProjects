# Obfuscated Human Face Reconstruction

This is a project made for the "Vision and Cognitive Systems" course of Padova University and investigates how distorted images of human faces 
can be recovered using Convolutional Neural Networks.

Despite being the key factor in the network's learning, the loss function has received little attention from the image processing research community, as
the Mean Squared Error/L2 norm is predominantly used to calculate the difference in pixels between the two images. 
Unfortunately, L2 is not able to accurately predict how good an image appears to a human observer. 

For this reason, I investigate the use of three alternative error metrics (L1, peak signal to noise ratio (PSNR), and SSIM) and define 
a new metric that combines PSNR and SSIM. Moreover, I conduct a detailed analysis of the results obtained by three different CNN models, 
using PSNR and SSIM also as evaluation metrics of the quality of the image reconstruction.

## Related Work

This project is inspired by prior work on image reconstruction tasks and Single Image Super-Resolution, but the main inspiration comes from:

-Hang Zhao et al. - "Loss Functions for Image Restoration with Neural Networks" (2018)

-Jacob Conrad Trinidad - "Reconstructing Obfuscated Human Faces" (2017)

-Ledig, et al. - "Photo-realistic Single Image Super-resolution using a Generative Adversarial Network" (2017)

Two of my three models will be a slightly modified version of the models used in the last two papers, 
so we have one model made for Image SR tasks and one made for obfuscated human face reconstruction.
The third model is instead a very simple CNN which is going to be used as baseline.

## Dataset

For this project I have used the Labeled Faces in the Wild dataset. This dataset contains 13,233 images collected from the web divided between pictures of 
5,749 different people. A benefit of using this dataset is that the images are already processed to have the faces fully captured and centered around the image.
Due to Google Colab restrictions on RAM and GPU usage, I decided to use only 2500 images, which were randomly split into 2000 training samples and 500 testing samples. 
Then I obfuscated each image indipendently using two methods: pixelation, also known as mosaicking, and Gaussian blurs. 

## Implementation Details

The project is implemented in Python and uses the Keras deep learning library for building and training the CNN. 
The datasets used for training and testing the models are the obfuscated face images obtained with the two methods, and their corresponding ground truth images.
These sets are then preprocessed using Min-Max Scaling to scale the pixel values to the range [0,1].
The models are then trained on the two dataset using the 5 loss functions described before,
and they achieve a high accuracy in reconstructing obfuscated faces, especially when SSIM and SSIM+PSNR are used as loss functions.

More details are described in the report of the project in the file `Report.pdf`

## Files

The following files are included in this project:
- `Models.ipynb`: This file show a brief summary of the structure of the three models.
- `Obfuscated_Human_Face_Reconstruction.ipynb` and `obfuscated_human_face_reconstruction.py`: .ipynb and .py versions of the full code.
- `Presentation.pdf`: Presentation of the full project made for the exam of the course.
- `Report.pdf`: Full report of the project.

## Conclusion

In this project I concentrate on the loss functions, an aspect of neural networks that is typically neglected when exploring image restoration.
I proposed several alternatives to L2, like L1, PSNR and SSIM and analyzed their effects on 3 different CNN architectures to show their improved performance 
on the networks, highlighting the improvement obtained with SSIM loss compared to L2. 
Moreover, I also define a novel loss that combines the SSIM and PSNR loss functions. 
