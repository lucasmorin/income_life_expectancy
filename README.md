This repository contains the code behind our upcoming article about income inequalities in life expectancy among older people in Sweden, by Stefan Fors, Jonas W Wastesson and Lucas Morin ([Karolinska Institutet](https://ki.se/en/startpage), Stockholm). 

## License
All of the files in this repository are released to the public domain under a GNU General Public License v3.0 (```gpl-3.0```)
 to allow for the widest possible reuse. Users should simply cite the authors of this code.

## Organisation of the code
This code is organised in a single pipeline, which loads the data, creates the necessary variables, splits the main dataset into year-specific data tables, and executes all the do-files from start to finish. The file [```Pipeline.do```](https://github.com/lucasmorin/income_life_expectancy/blob/master/Pipeline.do) consists of 4 main parts:
1. Calculate life expectancy by quartile of income
2. Calculate life expectancy by decile of income
3. Sensitivity and post-hoc analyses
4. Life expectancy by level of education

Life expectancy estimates are calculated according to 3 types of analyses:
* Analysis stratified by sex, neighborhood deprivation and degree of urbanicity
* Analysis stratified by sex and neighborhood deprivation, but not by degree of urbanicity
* Analysis stratified by sex, but not by neighborhood deprivation and degree of urbanicity

## Replication of the results
### Syntax
This code is written in Stata. It has been tested in Stata 13, Stata 14 and Stata 15.
### Availability of the data
The individual-level data that we used for our own study cannot be made publicly available for legal and ethical reasons. We are only authorised to share aggregated results. However, we provide a mock data file ([```dataset.dta```](https://github.com/lucasmorin/income_life_expectancy/blob/master/dataset.dta)) that you can download to see how the data should be structured.
### Running the code
**Step 1.** Download a copy of the code by clicking the "Clone or download" button at the top-right corner of the page and selecting "Download ZIP". Unzip this file on your computer. It will create a folder named ```income_life_expectancy-master```.

**Step 2.** Copy-paste the path to this root folder (e.g. ```/Users/name/income_life_expectancy-master```) into the do-file named [```path.do```](https://github.com/lucasmorin/income_life_expectancy/blob/master/path.do). Save this file.

**Step 3.** Run the file [```Pipeline.do```](https://github.com/lucasmorin/income_life_expectancy/blob/master/Pipeline.do). Please keep in mind that, depending on the size of your main dataset, the data generation process can take a long time. The complete pipeline will generate a total of 6450 life tables, which will then be stitched together to produce 14 result tables.

## Final results (life expectancy estimates)
The final results will be posted online shortly. 

* File 1 - Life expectancy by sex, age, income quartile, level of neighborhood deprivation, and degree of urbanicity
* File 2 - Life expectancy by sex, age, income quartile, and level of neighborhood deprivation
* File 3 - Life expectancy by sex, age, and income quartile (main analysis)
* File 4 - Life expectancy by sex, age, income decile, level of neighborhood deprivation, and degree of urbanicity
* File 5 - Life expectancy by sex, age, and income decile
* File 6 - Life expectancy by sex, age, and income quartile (excluding people with negative or no income)
* File 7 - Life expectancy by sex, age, and income decile (excluding people with negative or no income)
* File 8 - Life expectancy by sex, age, and income quartile (individual income)
* File 9 - Life expectancy by sex, age, and income decile (individual income)
* File 10 - Life expectancy by sex, age, level of education, level of neighborhood deprivation, and degree of urbanicity
* File 11 - Life expectancy by sex, age, and level of education
* File 12 - Life expectancy by sex, age, income quartile, and level of education (sex- and age-specific income quartiles)
* File 13 - Life expectancy by sex, age, income quartile, and level of education (sex-, age and education-specific income quartiles)
* File 14 - Life expectancy by sex, age, and income ventiles

## Contact information
Lucas Morin, Aging Research Center, Karolinska Institutet (lucas.morin@ki.se)
