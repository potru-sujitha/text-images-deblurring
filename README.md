# 🧠 Text Image Deblurring using Hybrid Dictionary

## 📌 Overview

This project focuses on restoring blurred text images using a **text-specific hybrid dictionary approach**.
It improves readability by reconstructing sharp text from degraded inputs using **sparse representation and patch-based reconstruction techniques**.

---

## 🔗 Relation to Paper

This repository contains the **implementation of the method proposed in the published research paper**, demonstrating how hybrid dictionary learning can be applied to restore blurred text images effectively.

---

## 📄 Published Paper

This implementation is based on the following research work:

📥 [Read Full Paper](docs/paper.pdf)

---

## 🚀 Features

* 🔹 Deblurring of degraded text images
* 🔹 Patch-based image reconstruction
* 🔹 Sparse coding using OMP (Orthogonal Matching Pursuit)
* 🔹 Dictionary-based learning approach
* 🔹 Improved readability of blurred text

---

## 🛠️ Tech Stack

* MATLAB
* Image Processing Toolbox

---

## ▶️ How to Run

1. Open MATLAB
2. Navigate to the project folder
3. Run the main script:

   ```matlab
   main.m
   ```
4. Place input images in:

   ```
   input_images/
   ```
5. Output images will be saved in:

   ```
   output_results/
   ```

---

## 📸 Results

### 🔹 Before (Blurred Image)

![Input](input_images/images1.png)

### 🔹 After (Deblurred Output)

![Output](output_results/images1_CLEAR_TEXT.png)

---

## 📂 Project Structure

text-image-deblurring/
│── README.md
│── main.m
├── src/
│   ├── extract_patch_features.m
│   ├── omp.m
│   ├── reconstruct_from_patches.m
├── data/
│   ├── THD_dictionary.mat
│   ├── reduced_features.mat
├── input_images/
├── output_results/
├── docs/
│   └── paper.pdf

---

## 📊 Key Concepts Used

* Sparse Representation
* Dictionary Learning
* Patch-based Image Processing
* Orthogonal Matching Pursuit (OMP)

---

## 👩‍💻 Author

**Sujitha Chowdary**

---

## ⭐ Acknowledgment

This project is inspired by research in **text image deblurring using hybrid dictionaries** and provides a practical implementation of the proposed method.
