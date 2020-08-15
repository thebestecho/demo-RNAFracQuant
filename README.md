# RNAFracQuant - RNA Fraction Quantification
Quantify the distribution of mRNA from various subcellular components in different fractions after centrifugation.

------------

# Introduction
This package employs a bayesian statistical model to quantify the distribution of mRNA in Saccharomyces Cerevisiae cells. The whole idea is based on this heat shock experiment:

*"To prepare RNA-seq data, cells are fractionated before cloning the resulting RNA into cDNA libraries. Then after centrifugation, granules with large molecular weight would deposit at the bottom and the others remain in the supernatant. Total transcripts and transcripts in the two factions (Supernatant, Pellet) are measured respectively both before and after heat shock. Therefore, for each transcript, we have a basic formula $N_{total} = N_{pellet} + N_{supernatant}$."*

![Experiment example design](man/figures/Experiment_design.png)

-----------

## 1.1 Required input files and their format
Users need to provide count files and a samplesheet file. Those files need to meet the conditions below:

**<span style="color:red;">1.</span> Both count files and samplesheet file need to be in the ".txt" format**  
**<span style="color:red;">2.</span> In count files, there should be only two columns (name of the transcripts and their respective count values);**
**<span style="color:red;">3.</span> In samplesheet file, there should be at least three columns "Condition", "Fraction" and "File"**  
**<span style="color:red;">4.</span> If there are multiple replicates, they can be specified in the column "Replicates". But this doesn't affect your results**  
**<span style="color:red;">5.</span> If there are multiple experimental groups, they <span style="color:red;">must</span> be specified in conditions instead of in a seperate column. This is because parameters involved in our model are estimated for conditions respectively**  
**<span style="color:red;">6.</span> For every line of comment, there should be a tag "#" at the begining of the text**  
**<span style="color:red;">7.</span> All the count files and the samplesheet file should be put in the same directory**  

**[Examples]**

Example sample sheet file for containing **multiple replicates** (e.g. two replicates):

|Condition | Fraction | File       | Replicates |
|  :----:  | :----:   |    :---:   |  :---:     |
| 30C	     | Tot	    |sample1.txt |	1         |
| 30C      | Sup      |sample2.txt |	1         |
| 30C	     | Pellet	  |sample3.txt |	1         |
| 30C      | Tot      |sample4.txt |	1         |
| 30C	     | Sup	    |sample5.txt |	1         |
| 30C      | Pellet   |sample6.txt |	1         |
| 40C	     | Tot	    |sample7.txt |	2         |
| 40C      | Sup      |sample8.txt |	2         |
| 40C	     | Pellet	  |sample9.txt |	2         |
| 40C      | Tot      |sample10.txt|	2         |
| 40C	     | Sup	    |sample11.txt|	2         |
| 40C      | Pellet   |sample12.txt|	2         |


Example sample sheet file for containing **multiple experimental groups** (e.g. WT versus KO):

|Condition | Fraction | File       |
|  :----:  | :----:   |    :---:   |
| 30C_WT	 | Tot	    |sample1.txt |
| 30C_WT   | Sup      |sample2.txt |
| 30C_WT	 | Pellet	  |sample3.txt |
| 40C_WT   | Tot      |sample4.txt |
| 40C_WT	 | Sup	    |sample5.txt |        
| 40C_WT   | Pellet   |sample6.txt |
| 30C_KO	 | Tot	    |sample7.txt |
| 30C_KO   | Sup      |sample8.txt |
| 30C_KO	 | Pellet	  |sample9.txt |
| 40C_KO   | Tot      |sample10.txt|
| 40C_KO	 | Sup	    |sample11.txt|
| 40C_KO   | Pellet   |sample12.txt|

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

R will load the knitr package to build these vignettes to HTML files, and you can see them when you type the command lines below.

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
result_data <- each_mRNA_pSup(wide_data = mydata)
write_results(result_data)
```

---------



# Issues update
If you get any problems with this package, you could update your questions [here](https://github.com/thebestecho/demo-RNAFracQuant/issues).
