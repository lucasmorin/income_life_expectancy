**************************************************************************************
****      INCOME AND LIFE EXPECTANCY AMONG OLDER ADULTS IN SWEDEN (2005-2015)     ****
**************************************************************************************

*----------------------------------------------------------------------------------* 
* Program Setup

	version 14 // set Stata version
	set more off // disable "more" output
	clear all // clear memory
	log close _all
	local datelog : di %tdDD-NN-CCYY date(c(current_date),"DMY")
	log using income_LE_`datelog'.txt, replace text // create log
*----------------------------------------------------------------------------------* 
	

*----------------------------------------------------------------------------------* 
* Information about the do-file:
* 
* Author: Lucas Morin, Karolinska Institutet (lucas.morin@ki.se)
* Co-investigators: Stefan Fors (KI) and Jonas Wastesson (KI)
* Date creation : 21 February 2018
* Extensive updates on 28 May 2018, 21 August 2018, and 31 January 2019
* Last update 18 April 2019
*----------------------------------------------------------------------------------*  


*----------------------------------------------------------------------------------* 
* Information about the dataset used for the study
* 
* Name of the file: dataset.dta
* Date of llast modification: 28 Feb 2018 at 18:24
* Size: 2.62 GB
* Number of variables: 39
* Number of observations: 20,037,836
* Number of distinct individuals: 2 738 170
* Contributing time from 'date_entry' to 'date_exit': 18 968 654.8 person-years
* Contributing time in 2006–2015: 17 409 578
*----------------------------------------------------------------------------------*  


*----------------------------------------------------------------------------------*
* Install the packages necessary for this syntax
	net from http://www.stata.com/stb/stb59/
	net install ssa14.pkg

	net from http://fmwww.bc.edu/RePEc/bocode/g
	net install gtools
		gtools, upgrade

*----------------------------------------------------------------------------------*
* Define the main directory, create subfolder and copy-paste the path

do path.do, nostop // the directory is indicated in a .dofile copied into each subfolder.

 mkdir "Final estimates"
   copy path.do "Final estimates/", replace
	
 mkdir "Life expectancy estimates (appended tables)"
   copy path.do "Life expectancy estimates (appended tables)/", replace
	
 mkdir "Life expectancy estimates (individual tables)"
   copy path.do "Life expectancy estimates (individual tables)/", replace
*----------------------------------------------------------------------------------*

   
****************************************************************
*** Part 1 - CALCULATE LIFE EXPECTANCY BY QUARTILE OF INCOME ***
****************************************************************

* Choose the different variables and split the file by year
do path.do, nostop
 
 	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		
		gen age = round((date_entry-date_birth)/365.25) // generate 'age' variable, integer
			replace age =95 if age>=95 // bound age to 95 to minimize estimation error in the age-specific income quantiles
		
		gen income = dispinkke04_normalized // choose income variable
			replace income = dispinkke_normalized if `i'==2005 // choose different income variable for 2005
			replace income = 0 if income<0 // replace negative income by '0'
		
		fasterxtile level_income = income, n(4) by(sex age)  // cut into quartiles (sex- and age-specific)
		
		gen urban = urban_density // choose urbanicity variable
		gen deprivation = deprivation_quartiles_pca // choose deprivation variable
	  
	  save year`i', replace
	 }

* Part 1.1 – Create life tables by quartiles of income (analysis stratified by sex, neighborhood deprivation and degree of urbanicity)

   // 2005
   do path.do, nostop
   do life_table_year2005_quartiles_income.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_quartiles_income.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_quartiles_income.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_quartiles_income.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_quartiles_income.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_quartiles_income.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_quartiles_income.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_quartiles_income.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_quartiles_income.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_quartiles_income.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_quartiles_income.do, nostop
   
   
* Append all years into a single file (stratified by quartile of income, sex, neighborhood deprivation and degree of urbanicity)
   
   do path.do, nostop
   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005.dta"
	gen year=2005
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006.dta"
	replace year=2006 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007.dta"
	replace year=2007 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008.dta"
	replace year=2008 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009.dta"
	replace year=2009 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010.dta"
	replace year=2010 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011.dta"
	replace year=2011 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012.dta"
	replace year=2012 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013.dta"
	replace year=2013 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014.dta"
	replace year=2014 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015.dta"
	replace year=2015 if year==.
   
		save "Final estimates/LE_quartiles_income_2005-2015_stratified.dta", replace
	
   
* Part 1.2 – Create life tables by quartiles of income (analysis stratified by sex and neighborhood deprivation, but not by urbanicity)

   // 2005
   do path.do, nostop
   do life_table_year2005_quartiles_income_no_urbanicity.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_quartiles_income_no_urbanicity.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_quartiles_income_no_urbanicity.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_quartiles_income_no_urbanicity.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_quartiles_income_no_urbanicity.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_quartiles_income_no_urbanicity.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_quartiles_income_no_urbanicity.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_quartiles_income_no_urbanicity.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_quartiles_income_no_urbanicity.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_quartiles_income_no_urbanicity.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_quartiles_income_no_urbanicity.do, nostop
   
   
   * Append all years into a single file (stratified by quartile of income, sex and neighborhood deprivation, but not by urbanicity)
   
   do path.do, nostop
   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_no_urban.dta"
	gen year=2005
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_no_urban.dta"
	replace year=2006 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_no_urban.dta"
	replace year=2007 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_no_urban.dta"
	replace year=2008 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_no_urban.dta"
	replace year=2009 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_no_urban.dta"
	replace year=2010 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_no_urban.dta"
	replace year=2011 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_no_urban.dta"
	replace year=2012 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_no_urban.dta"
	replace year=2013 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_no_urban.dta"
	replace year=2014 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_no_urban.dta"
	replace year=2015 if year==.
   
		save "Final estimates/LE_quartiles_income_20052015_stratified_no_urban.dta", replace

   
   
* Part 1.3 – Create life tables by quartiles of income (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)


   // 2005
   do path.do, nostop
   do life_table_year2005_quartiles_income_nonstratified.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_quartiles_income_nonstratified.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_quartiles_income_nonstratified.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_quartiles_income_nonstratified.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_quartiles_income_nonstratified.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_quartiles_income_nonstratified.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_quartiles_income_nonstratified.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_quartiles_income_nonstratified.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_quartiles_income_nonstratified.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_quartiles_income_nonstratified.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_quartiles_income_nonstratified.do, nostop
   
   
   * Append all years into a single file (stratified by quartile of income and sex, but not by neighborhood deprivation or urbanicity)
   
   do path.do, nostop
   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_nonstratified.dta"
   gen year=2005
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_nonstratified.dta"
   replace year=2006 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_nonstratified.dta"
   replace year=2007 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_nonstratified.dta"
   replace year=2008 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_nonstratified.dta"
   replace year=2009 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_nonstratified.dta"
   replace year=2010 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_nonstratified.dta"
   replace year=2011 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_nonstratified.dta"
   replace year=2012 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_nonstratified.dta"
   replace year=2013 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_nonstratified.dta"
   replace year=2014 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_nonstratified.dta"
   replace year=2015 if year==.
   
	save "Final estimates/LE_quartiles_income_2005-2015_nonstratified.dta", replace   

  

****************************************************************
*** Part 2 -  CALCULATE LIFE EXPECTANCY BY DECILE OF INCOME  ***
****************************************************************

* Choose the different variables and split the file by year (see part 1 for explanations about the setup)
 
do path.do, nostop

 	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		gen income = dispinkke04_normalized
			replace income = dispinkke_normalized if `i'==2005
			replace income = 0 if income<0
		fasterxtile level_income = income, n(10) by(sex age)
		gen urban = urban_density
		gen deprivation = deprivation_quartiles_pca
	  save year`i', replace
	 }
   
* Part 2.1 – Create life tables by deciles of income (analysis stratified by sex, neighborhood deprivation and degree of urbanicity)

   // 2005
   do path.do, nostop
   do life_table_year2005_deciles_income.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_deciles_income.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_deciles_income.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_deciles_income.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_deciles_income.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_deciles_income.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_deciles_income.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_deciles_income.do, nostop
    
   // 2013
   do path.do, nostop
   do life_table_year2013_deciles_income.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_deciles_income.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_deciles_income.do, nostop
 
   * Append all years into a single file (stratified by decile of income, sex, neighborhood deprivation and degree of urbanicity)
   
   do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_deciles_income_2005.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2006.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2007.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2008.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2009.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2010.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2011.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2012.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2013.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2014.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2015.dta"
	   replace year=2015 if year==.

	   save "Final estimates/LE_deciles_income_2005-2015_stratified.dta", replace

* Part 2.2 – Create life tables by deciles of income (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)

   // 2005
   do path.do, nostop
   do life_table_year2005_deciles_income_nonstratified.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_deciles_income_nonstratified.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_deciles_income_nonstratified.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_deciles_income_nonstratified.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_deciles_income_nonstratified.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_deciles_income_nonstratified.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_deciles_income_nonstratified.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_deciles_income_nonstratified.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_deciles_income_nonstratified.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_deciles_income_nonstratified.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_deciles_income_nonstratified.do, nostop
 
   * Append all years into a single file (stratified by decile of income and sex, but not by neighborhood deprivation or degree of urbanicity)
 
    do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_deciles_income_2005_nonstratified.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2006_nonstratified.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2007_nonstratified.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2008_nonstratified.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2009_nonstratified.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2010_nonstratified.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2011_nonstratified.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2012_nonstratified.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2013_nonstratified.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2014_nonstratified.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2015_nonstratified.dta"
	   replace year=2015 if year==.

   do path.do, nostop
   save "Final estimates/LE_deciles_income_2005-2015_nonstratified.dta", replace   


****************************************************************
*** Part 3 - SENSITIVITY AND POST-HOC ANALYSES               ***
****************************************************************

*------------------------------------------------------------* 
* Note: Part 3 was added on 31 January 2019.
*------------------------------------------------------------* 


* Part 3.1 – Calculate life expectancy by quartiles of income while excluding people with no income ('income<=0')

	* Choose the different variables and split the file by year (see part 1 for explanations about the setup)
 
	do path.do, nostop

 	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		gen income = dispinkke04_normalized
		replace income = dispinkke_normalized if `i'==2005
			drop if income<=0 // Excluding people with negative or no income
		
		fasterxtile level_income = income, n(4) by(sex age)
		gen urban = urban_density
		gen deprivation = deprivation_quartiles_pca
	  save year`i', replace
	 }
	 
* Create life tables by quartiles of income while excluding people with no income (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)   
	
   // 2005
   do path.do, nostop
   do life_table_year2005_quartiles_income_nonstratified.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_quartiles_income_nonstratified.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_quartiles_income_nonstratified.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_quartiles_income_nonstratified.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_quartiles_income_nonstratified.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_quartiles_income_nonstratified.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_quartiles_income_nonstratified.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_quartiles_income_nonstratified.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_quartiles_income_nonstratified.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_quartiles_income_nonstratified.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_quartiles_income_nonstratified.do, nostop
   
   
   * Append all years into a single file (stratified by quartile of income and sex, but not by neighborhood deprivation or urbanicity)
   
    do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_nonstratified.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_nonstratified.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_nonstratified.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_nonstratified.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_nonstratified.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_nonstratified.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_nonstratified.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_nonstratified.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_nonstratified.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_nonstratified.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_nonstratified.dta"
	   replace year=2015 if year==.
	   
	   save "Final estimates/LE_quartiles_income_2005-2015_nonstratified_excluding_no_income.dta", replace   
   
	* Note: this will produce the same table as in Part 1.3, but without taking into account people with income <= 0
   

* Part 3.2 – Calculate life expectancy by deciles of income while excluding people with no income ('income<=0')

	* Choose the different variables and split the file by year (see part 1 for explanations about the setup)
	
	do path.do, nostop

  	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		
		gen income = dispinkke04_normalized
		replace income = dispinkke_normalized if `i'==2005
			drop if income<=0 // Excluding people with negative or no income
		
		fasterxtile level_income = income, n(10) by(sex age)
			gen urban = urban_density
			gen deprivation = deprivation_quartiles_pca
	  save year`i', replace
	 }
	 
* Create life tables by deciles of income while excluding people with no income (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)   
 
   // 2005
   do path.do, nostop
   do life_table_year2005_deciles_income_nonstratified.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_deciles_income_nonstratified.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_deciles_income_nonstratified.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_deciles_income_nonstratified.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_deciles_income_nonstratified.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_deciles_income_nonstratified.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_deciles_income_nonstratified.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_deciles_income_nonstratified.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_deciles_income_nonstratified.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_deciles_income_nonstratified.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_deciles_income_nonstratified.do, nostop
 
   * Append all years into a single file (stratified by decile of income and sex, but not by neighborhood deprivation or urbanicity)
 
    do path.do, nostop
   
	   use "Life expectancy estimates (appended tables)/LE_deciles_income_2005_nonstratified.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2006_nonstratified.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2007_nonstratified.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2008_nonstratified.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2009_nonstratified.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2010_nonstratified.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2011_nonstratified.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2012_nonstratified.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2013_nonstratified.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2014_nonstratified.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2015_nonstratified.dta"
	   replace year=2015 if year==.
	
	   do path.do, nostop
	   save "Final estimates/LE_deciles_income_2005-2015_nonstratified_excluding_no_income.dta", replace
  
   * Note: this will produce the same table as in Part 2.2, but without taking into account people with income <= 0


* Part 3.3 – Change the definition of income ('raks_summaink_normalized' instead of 'dispinkke04_normalized'), divided into QUARTILES
  

	* Choose the different variables and split the file by year (see part 1 for explanations about the setup) 
    
	do path.do, nostop

 	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		gen income = raks_summaink_normalized // The income variable is now "raks_summaink_normalized" instead of "dispinkke04_normalized"
			replace income = 0 if income<0
		fasterxtile level_income = income, n(4) by(sex age)  // cut into quartiles (sex- and age-specific)
		gen urban = urban_density
		gen deprivation = deprivation_quartiles_pca
	  save year`i', replace
	 }

	* Create life tables by quartiles of income using the 'raks_summaink_normalized' variable (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)
	
		// 2005
	   do path.do, nostop
	   do life_table_year2005_quartiles_income_nonstratified.do, nostop
	 
	   // 2006
	   do path.do, nostop
	   do life_table_year2006_quartiles_income_nonstratified.do, nostop
	 
	   // 2007
	   do path.do, nostop
	   do life_table_year2007_quartiles_income_nonstratified.do, nostop
	   
	   // 2008
	   do path.do, nostop
	   do life_table_year2008_quartiles_income_nonstratified.do, nostop
	   
	   // 2009
	   do path.do, nostop
	   do life_table_year2009_quartiles_income_nonstratified.do, nostop
	   
	   // 2010
	   do path.do, nostop
	   do life_table_year2010_quartiles_income_nonstratified.do, nostop
	   
	   // 2011
	   do path.do, nostop
	   do life_table_year2011_quartiles_income_nonstratified.do, nostop
	   
	   // 2012
	   do path.do, nostop
	   do life_table_year2012_quartiles_income_nonstratified.do, nostop
	   
	   // 2013
	   do path.do, nostop
	   do life_table_year2013_quartiles_income_nonstratified.do, nostop
		  
	   // 2014
	   do path.do, nostop
	   do life_table_year2014_quartiles_income_nonstratified.do, nostop
		  
	   // 2015
	   do path.do, nostop
	   do life_table_year2015_quartiles_income_nonstratified.do, nostop
   
   
   * Append all years into a single file (stratified by quartile of income and sex, but not by neighborhood deprivation or urbanicity)
    
	do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_nonstratified.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_nonstratified.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_nonstratified.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_nonstratified.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_nonstratified.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_nonstratified.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_nonstratified.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_nonstratified.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_nonstratified.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_nonstratified.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_nonstratified.dta"
	   replace year=2015 if year==.
	   
		save "Final estimates/LE_quartiles_income_2005-2015_nonstratified_raks_summaink.dta", replace   
		
		* Note: this will produce the same table as in Part 1.3, but with a different definition of income
	
	
* Part 3.4 – Change the definition of income ('raks_summaink_normalized' instead of 'dispinkke04_normalized'), divided into DECILES

	* Choose the different variables and split the file by year (see part 1 for explanations about the setup)
	
	 do path.do, nostop

 	 forval i = 2005/2015 {
	 use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		gen income = raks_summaink_normalized // The income variable is now "raks_summaink_normalized" instead of "dispinkke04_normalized"
			replace income = 0 if income<0
		fasterxtile level_income = income, n(10) by(sex age)  // cut into deciles (sex- and age-specific)
		gen urban = urban_density
		gen deprivation = deprivation_quartiles_pca
	  save year`i', replace
	 }

	 * Create life tables by deciles of income using the 'raks_summaink_normalized' variable (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)
 
	   // 2005
	   do path.do, nostop
	   do life_table_year2005_deciles_income_nonstratified.do, nostop
	 
	   // 2006
	   do path.do, nostop
	   do life_table_year2006_deciles_income_nonstratified.do, nostop
	 
	   // 2007
	   do path.do, nostop
	   do life_table_year2007_deciles_income_nonstratified.do, nostop
	   
	   // 2008
	   do path.do, nostop
	   do life_table_year2008_deciles_income_nonstratified.do, nostop
	   
	   // 2009
	   do path.do, nostop
	   do life_table_year2009_deciles_income_nonstratified.do, nostop
	   
	   // 2010
	   do path.do, nostop
	   do life_table_year2010_deciles_income_nonstratified.do, nostop
	   
	   // 2011
	   do path.do, nostop
	   do life_table_year2011_deciles_income_nonstratified.do, nostop
	   
	   // 2012
	   do path.do, nostop
	   do life_table_year2012_deciles_income_nonstratified.do, nostop
	   
	   // 2013
	   do path.do, nostop
	   do life_table_year2013_deciles_income_nonstratified.do, nostop
		  
	   // 2014
	   do path.do, nostop
	   do life_table_year2014_deciles_income_nonstratified.do, nostop
		  
	   // 2015
	   do path.do, nostop
	   do life_table_year2015_deciles_income_nonstratified.do, nostop
 
   * Append all years into a single file (stratified by decile of income and sex, but not by neighborhood deprivation or urbanicity)
 
    do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_deciles_income_2005_nonstratified.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2006_nonstratified.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2007_nonstratified.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2008_nonstratified.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2009_nonstratified.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2010_nonstratified.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2011_nonstratified.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2012_nonstratified.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2013_nonstratified.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2014_nonstratified.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_deciles_income_2015_nonstratified.dta"
	   replace year=2015 if year==.
	
	   do path.do, nostop
	   save "Final estimates/LE_deciles_income_2005-2015_nonstratified_raks_summaink.dta", replace
	
		* Note: this will produce the same table as in Part 2.2, but with a different definition of income

   
* Part 3.5 – Main analysis stratified by both quartile of income AND by level of education [post-hoc analysis]

	* Option 1: quartiles are calculated on the basis of sex- and age-specific income, but not within each education stratum

	* Choose the different variables and split the file by year (see part 1 for explanations about the setup)

	 do path.do, nostop

	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		gen income = dispinkke04_normalized
		replace income = dispinkke_normalized if `i'==2005
			replace income = 0 if income<=0
		
		fasterxtile level_income = income, n(4) by(sex age)  // cut into quartiles (sex- and age-specific)
		
		gen urban = 1 // set urban at 1 for everyone
		gen deprivation = level_education // replace area-level deprivation by education variable
	  save year`i', replace
	 }
  
  * Create life tables by quartile of income and level of education (stratified by sex)
  * Note: for the purpose of this analysis, the variable 'deprivation' corresponds to 'education'. This allows for recycling the syntax used in Part 1.2.

	// 2005
   do path.do, nostop
   do life_table_year2005_quartiles_income_no_urbanicity.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_quartiles_income_no_urbanicity.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_quartiles_income_no_urbanicity.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_quartiles_income_no_urbanicity.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_quartiles_income_no_urbanicity.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_quartiles_income_no_urbanicity.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_quartiles_income_no_urbanicity.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_quartiles_income_no_urbanicity.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_quartiles_income_no_urbanicity.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_quartiles_income_no_urbanicity.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_quartiles_income_no_urbanicity.do, nostop
   
   
   * Append all years into a single file (stratified by sex, income quartile and level of education)
    
	do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_no_urban.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_no_urban.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_no_urban.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_no_urban.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_no_urban.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_no_urban.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_no_urban.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_no_urban.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_no_urban.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_no_urban.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_no_urban.dta"
	   replace year=2015 if year==.
				
			rename deprivation education // rename the variable for later use (for clarity)
			replace education = . if education==4 // education is missing if education == 4
		
		do path.do, nostop
		save "Final estimates/LE_quartiles_income_and_education_2005-2015_SexAge_income.dta", replace   
		
		* Note: This will produce life expectancy estimates for each sex * income quartile * education level

		
* Option 2: quartiles are calculated on the basis of sex-, age- and education-specific income
	
	* Choose the different variables and split the file by year (see part 1 for explanations about the setup)
	
	do path.do, nostop
	
	forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		
		gen income = dispinkke04_normalized
			replace income = dispinkke_normalized if `i'==2005
			replace income = 0 if income<=0
		fasterxtile level_income = income, n(4) by(sex age level_education)  // cut into sex-, age- and education-specific quartiles
		gen urban = 1 // set urban at 1 for everyone
		gen deprivation = level_education // replace area-level deprivation by education variable
	  save year`i', replace
	 }
  
    * Create life tables by quartile of income and level of education (stratified by sex)
	* Note: for the purpose of this analysis, the variable 'deprivation' corresponds to 'education'. This allows for recycling the syntax used in Part 1.2.

		// 2005
	   do path.do, nostop
	   do life_table_year2005_quartiles_income_no_urbanicity.do, nostop
	 
	   // 2006
	   do path.do, nostop
	   do life_table_year2006_quartiles_income_no_urbanicity.do, nostop
	 
	   // 2007
	   do path.do, nostop
	   do life_table_year2007_quartiles_income_no_urbanicity.do, nostop
	   
	   // 2008
	   do path.do, nostop
	   do life_table_year2008_quartiles_income_no_urbanicity.do, nostop
	   
	   // 2009
	   do path.do, nostop
	   do life_table_year2009_quartiles_income_no_urbanicity.do, nostop
	   
	   // 2010
	   do path.do, nostop
	   do life_table_year2010_quartiles_income_no_urbanicity.do, nostop
	   
	   // 2011
	   do path.do, nostop
	   do life_table_year2011_quartiles_income_no_urbanicity.do, nostop
	   
	   // 2012
	   do path.do, nostop
	   do life_table_year2012_quartiles_income_no_urbanicity.do, nostop
	   
	   // 2013
	   do path.do, nostop
	   do life_table_year2013_quartiles_income_no_urbanicity.do, nostop
		  
	   // 2014
	   do path.do, nostop
	   do life_table_year2014_quartiles_income_no_urbanicity.do, nostop
		  
	   // 2015
	   do path.do, nostop
	   do life_table_year2015_quartiles_income_no_urbanicity.do, nostop
   
   
   * Append all years into a single file (stratified by sex, income quartile and level of education
   
    do path.do, nostop
	   use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_no_urban.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_no_urban.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_no_urban.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_no_urban.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_no_urban.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_no_urban.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_no_urban.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_no_urban.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_no_urban.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_no_urban.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_no_urban.dta"
	   replace year=2015 if year==.
			rename deprivation education // rename the variable for later use (for clarity)
			replace education = . if education==4 // education is missing if education == 4
			
			do path.do, nostop
			save "Final estimates/LE_quartiles_income_and_education_2005-2015_SexAgeEducation_income.dta", replace  
	
	* Note: This will produce life expectancy estimates for each sex * income quartile * education level.
		

* Part 3.6 – Main analysis stratified by ventile (5-percentile bins) of income

	* Choose the different variables and split the file by year (see part 1 for explanations about the setup)
	 
		do path.do, nostop
	
		forval i = 2005/2015 {
		  use "dataset.dta" if year == `i', clear 
			
			gen age = round((date_entry-date_birth)/365.25)
				replace age =95 if age>=95
			
			gen income = dispinkke04_normalized
				replace income = dispinkke_normalized if `i'==2005
				replace income = 0 if income<=0
			
			fasterxtile level_income = income, n(20) by(sex age)  // cut into ventiles (sex- and age-specific)
			
			drop if level_income >2 & level_income<19 // we are only interested in the first 2 and the last 2 ventiles (# 1, 2, 19 and 20)
			
				// The ventiles are recoded to allow for recycling the syntaxt from the main analysis (part 1.3)
				replace level_income = 1 if level_income ==1
				replace level_income = 2 if level_income ==2
				replace level_income = 3 if level_income ==19
				replace level_income = 4 if level_income ==20
				
			gen urban = urban_density // this variable will not be used for this part of the analysis
			gen deprivation = deprivation_quartiles_pca // this variable will not be used for this part of the analysis
		  
		  save year`i', replace
		 }

	* Create life tables for the chosen ventiles of income (analysis stratified by sex, but not by neighborhood deprivation or urbanicity)
	   // 2005
	   do path.do, nostop
	   do life_table_year2005_quartiles_income_nonstratified.do, nostop
	 
	   // 2006
	   do path.do, nostop
	   do life_table_year2006_quartiles_income_nonstratified.do, nostop
	 
	   // 2007
	   do path.do, nostop
	   do life_table_year2007_quartiles_income_nonstratified.do, nostop
	   
	   // 2008
	   do path.do, nostop
	   do life_table_year2008_quartiles_income_nonstratified.do, nostop
	   
	   // 2009
	   do path.do, nostop
	   do life_table_year2009_quartiles_income_nonstratified.do, nostop
	   
	   // 2010
	   do path.do, nostop
	   do life_table_year2010_quartiles_income_nonstratified.do, nostop
	   
	   // 2011
	   do path.do, nostop
	   do life_table_year2011_quartiles_income_nonstratified.do, nostop
	   
	   // 2012
	   do path.do, nostop
	   do life_table_year2012_quartiles_income_nonstratified.do, nostop
	   
	   // 2013
	   do path.do, nostop
	   do life_table_year2013_quartiles_income_nonstratified.do, nostop
		  
	   // 2014
	   do path.do, nostop
	   do life_table_year2014_quartiles_income_nonstratified.do, nostop
		  
	   // 2015
	   do path.do, nostop
	   do life_table_year2015_quartiles_income_nonstratified.do, nostop
   
   
   * Append all years into a single file (stratified by sex and income ventile)
		do path.do, nostop
		
			use "Life expectancy estimates (appended tables)/LE_quartiles_income_2005_nonstratified.dta"
			gen year=2005
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2006_nonstratified.dta"
			replace year=2006 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2007_nonstratified.dta"
			replace year=2007 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2008_nonstratified.dta"
			replace year=2008 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2009_nonstratified.dta"
			replace year=2009 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2010_nonstratified.dta"
			replace year=2010 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2011_nonstratified.dta"
			replace year=2011 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2012_nonstratified.dta"
			replace year=2012 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2013_nonstratified.dta"
			replace year=2013 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2014_nonstratified.dta"
			replace year=2014 if year==.
			append using  "Life expectancy estimates (appended tables)/LE_quartiles_income_2015_nonstratified.dta"
			replace year=2015 if year==.
			   replace level_income = 19 if level_income==3 // recode the 19th ventile for clarity
			   replace level_income = 20 if level_income==4 // recode the 20th ventile for clarity
			  
			   save "Final estimates/LE_ventiles_income_2005-2015_NonStratified.dta", replace   
			   
		 * Note: this will produce the same table as in Part 1.3, but with ventiles instead of quartiles 


****************************************************************
*** Part 4 -   LIFE EXPECTANCY BY LEVEL OF EDUCATION         ***
****************************************************************

*------------------------------------------------------------* 
* Note: Part 4 was added on 28 May 2018
* Update 31 January 2019: income quartiles calculated by age and sex
*------------------------------------------------------------* 

* Choose the different variables and split the file by year
do path.do, nostop
 
 	 forval i = 2005/2015 {
	  use "dataset.dta" if year == `i', clear 
		gen age = round((date_entry-date_birth)/365.25)
			replace age =95 if age>=95
		gen income = dispinkke04_normalized
			replace income = dispinkke_normalized if `i'==2005
			replace income = 0 if income<0
		fasterxtile level_income = income, n(4) by(sex age) // update 31 January 2019
		gen urban = urban_density // choose urbanicity variable
		gen deprivation = deprivation_quartiles_pca // choose deprivation variable
	  
	  save year`i', replace
	 }

	 
 * Create life tables for each level of education (analysis stratified by sex, neighborhood deprivation and urbanicity)
	
	// 2005
	do path.do, nostop
   do life_table_year2005_education.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_education.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_education.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_education.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_education.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_education.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_education.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_education.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_education.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_education.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_education.do, nostop
   
   * Append all years into a single file (stratified by level of education, sex, neighborhood deprivation and urbanicity)
   
   do path.do, nostop

   use "Life expectancy estimates (appended tables)/LE_quartiles_education_2005.dta"
   gen year=2005
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2006.dta"
   replace year=2006 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2007.dta"
   replace year=2007 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2008.dta"
   replace year=2008 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2009.dta"
   replace year=2009 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2010.dta"
   replace year=2010 if year==.   
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2011.dta"
   replace year=2011 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2012.dta"
   replace year=2012 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2013.dta"
   replace year=2013 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2014.dta"
   replace year=2014 if year==.
   append using  "Life expectancy estimates (appended tables)/LE_quartiles_education_2015.dta"
   replace year=2015 if year==.
   
	save "Final estimates/LE_education_2005-2015_stratified.dta", replace
   
   clear
   
* Create life tables for each level of education (analysis stratified by sex, but not by bneighborhood deprivation or urbanicity)

   // 2005
   do path.do, nostop
   do life_table_year2005_education_nonstratified.do, nostop
 
   // 2006
   do path.do, nostop
   do life_table_year2006_education_nonstratified.do, nostop
 
   // 2007
   do path.do, nostop
   do life_table_year2007_education_nonstratified.do, nostop
   
   // 2008
   do path.do, nostop
   do life_table_year2008_education_nonstratified.do, nostop
   
   // 2009
   do path.do, nostop
   do life_table_year2009_education_nonstratified.do, nostop
   
   // 2010
   do path.do, nostop
   do life_table_year2010_education_nonstratified.do, nostop
   
   // 2011
   do path.do, nostop
   do life_table_year2011_education_nonstratified.do, nostop
   
   // 2012
   do path.do, nostop
   do life_table_year2012_education_nonstratified.do, nostop
   
   // 2013
   do path.do, nostop
   do life_table_year2013_education_nonstratified.do, nostop
      
   // 2014
   do path.do, nostop
   do life_table_year2014_education_nonstratified.do, nostop
      
   // 2015
   do path.do, nostop
   do life_table_year2015_education_nonstratified.do, nostop
   
   
	* Append all years into a single file (analysis stratified by level of education and sex)
	   
	   do path.do, nostop
	   
	   use "Life expectancy estimates (appended tables)/LE_education_2005_nonstratified.dta"
	   gen year=2005
	   append using  "Life expectancy estimates (appended tables)/LE_education_2006_nonstratified.dta"
	   replace year=2006 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2007_nonstratified.dta"
	   replace year=2007 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2008_nonstratified.dta"
	   replace year=2008 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2009_nonstratified.dta"
	   replace year=2009 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2010_nonstratified.dta"
	   replace year=2010 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2011_nonstratified.dta"
	   replace year=2011 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2012_nonstratified.dta"
	   replace year=2012 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2013_nonstratified.dta"
	   replace year=2013 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2014_nonstratified.dta"
	   replace year=2014 if year==.
	   append using  "Life expectancy estimates (appended tables)/LE_education_2015_nonstratified.dta"
	   replace year=2015 if year==.
	   
	   do path.do, nostop
	   save "Final estimates/LE_education_2005_2015_nonstratified.dta", replace   

log close
