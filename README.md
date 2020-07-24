# RNAFracQuant - RNA Fraction Quantification
Employ a bayesian statistical model to quantify the distribution of mRNA in different fractions after centrifugation of subcellular components.

------------

# Introduction
This vignette introduces how to use the functions in this packge. This package employs a bayesian statistical model to quantify the distribution of mRNA in Saccharomyces Cerevisiae cells. The whole idea is based on this heat shock experiment:

*"To prepare RNA-seq data, cells are fractionated before cloning the resulting RNA into cDNA libraries. Then after centrifugation, granules with large molecular weight would deposit at the bottom and the others remain in the supernatant. Total transcripts and transcripts in the two factions (Supernatant, Pellet) are measured respectively both before and after heat shock. Therefore, for each transcript, we have a basic formula $N_{total} = N_{pellet} + N_{supernatant}$."*

![Experiment example design](man/figures/Experiment_design.png)

-----------

## Required input files and their format
Users need to provide count files and a samplesheet file. Those files need to meet the conditions below:

**<span style="color:red;">1.</span> Both count files and samplesheet file need to be in the ".txt" format**  
**<span style="color:red;">2.</span> In count files, there should be only two columns (name of the transcripts and their respective count values);**
**<span style="color:red;">3.</span> In samplesheet file, there should be at least three columns "Condition", "Fraction" and "File"**  
**<span style="color:red;">4.</span> For every line of comment, there should be a tag "#" at the begining of the text**  
**<span style="color:red;">5.</span> All the count files and the samplesheet file should be put in the same directory**  

Functions in this package are linked to each other. We aim to output the proportion value for each transcript in supernatant (pSup value) at the final step. Before you use this package, we strongly recommand you to check your experimental design and think about what results you expect to get.

-----------

# Installation

We recommand you to use package "devtools" for dowloading this package from GitHub. Please refer [devtools installation instructions](https://www.r-project.org/nosvn/pandoc/devtools.html) for more information.

```
install.packages("devtools")
library(devtools)
install_github("thebestecho/demo-RNAFracQuant",build_vignettes = TRUE)
```

Then load RNAFracQuant as a standard package:
```
library(RNAFracQuant)
```

---------

# View vignettes or documentation

R will load the knitr package to build these vignettes to HTML files, and you can see them when you type the commands lines below.

A list of vignettes in html format, including the function & data documentation.
```
help(package = "RNAFracQuant", help_type = "html")
```
Or you can view the single package vignette.
```
browseVignettes("RNAFracQuant")
```

----------------

## Quick guide

If you only want to get the pSup values for transcripts, the code below shows you the quickest way to get them with **RNAFracQuant**.
```
mydata <- get_wide_Fraction(dir_in = mydirectory, file = myfile)
result_data <- each_mRNA_pSup(wide_data = mydatda)
write_results(result_data)
```

---------



# Issues update
If you get any problems with this package, you could update your questions [here](https://github.com/thebestecho/demo-RNAFracQuant/issues).
