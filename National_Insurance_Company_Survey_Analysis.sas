/* Question 1 */
proc freq data=NATIONAL.NATIONAL;
	tables sex mstat age inc ed / plots=(freqplot cumfreqplot);
run;

/* Conclusion:
- Using the data provided in the case about the customer base of 
National Insurance Company,there are more male than female customers. 
Moreover, most of the customers are between 24 – 44 years of age 
and have bought insurance from the company for 5 years or more.
- The sample seems to capture these trends. Based on the sample, 
there are more male and female customers. In addition, most of the customers 
who responded to the survey are married, are between 24 – 44 years of age, 
make $30,000 - $49,999 in annual family income, and have completed 
high school or less.
*/


/* Question 2 */
proc freq data=NATIONAL.NATIONAL;
	tables age / chisq scores=table;
proc freq data=national.national order=internal; 
tables age / nocum chisq testp=(5 70 15 10);
run;

proc freq data=NATIONAL.NATIONAL;
	tables use / chisq scores=table;
	proc freq data=national.national order=internal;
	tables use / nocum chisq testp=(8 9 18 65);
run;

/* Conclusion:
- In terms of gender, we fail to reject the null hypothesis that 
the gender split is 0.54 using the chi-square test because the 
two-sided p-value is 0.5427 at the 95% confidence level. Therefore, 
the sample is statistically insignificantly different from the customer base.
- In terms of age, we reject the null hypothesis that the observed 
frequencies are (5 70 15 10) using a chi-square test because the p-value 
is < 0.0001 for the chi-square test at 95% confidence level. Therefore, 
the sample is statistically significantly different from the customer base. 
Under-represented age groups are 45 – 64 and 65 or over. Over-represented 
age groups are under 25 and 25 – 44.
- In terms of years with the company, we reject the null hypothesis that 
the observed frequencies are (8 9 18 65) using a chi-square test because 
the p-value is < 0.0001 at 95% confidence level. Therefore, the sample is 
statistically significantly different from the customer base. Under-represented 
use groups are 1 to less than 2 years, and 2 to less than 5 years. 
Over-represented use groups are less than 1 year, and 5 years or more.
*/


/* Question 3 */
ods noproctitle;
ods graphics / imagemap=on;

proc means data=NATIONAL.NATIONAL chartype mean std min max n vardef=df;
	var reliavrg empavrg tangavrg respavrg assuravg;
run;

/* Conclusion:
- National Insurance Company is rated the strongest in Assurance 
because the Assurance Average is the highest.
- National Insurance Company is rated the weakest in Reliability 
because the Reliability Average is the lowest.
*/


/* Question 4 */
ods noproctitle;
ods graphics / imagemap=on;

proc means data=NATIONAL.NATIONAL chartype mean std min max n vardef=df;
	var tanimp relimp resimp asrimp empimp;
run;

/* Conclusion:
- The least important service dimension is Tangibles 
because Tangibles Importance has the lowest mean.
- The most important service dimension is Reliability 
because Reliability Importance has the highest mean.
- Although Reliability is what National Insurance Company was rated 
highest on in terms of importance, it is not the strongest dimension. 
Instead, National Insurance Company is rated the strongest in Assurance.
*/


/* Question 5 */
ods noproctitle;
ods graphics / imagemap=on;

proc corr data=NATIONAL.NATIONAL pearson fisher (alpha=0.05 rho0=0 type=twosided) nosimple noprob plots=matrix;
	var oq;
	with reliavrg empavrg tangavrg respavrg assuravg;
run;

/* Conclusion:
- Reliability, Empathy, Responsiveness, and Assurance are the dimensions of 
service quality that are the most correlated with the perceived overall 
service quality, with correlation coefficients of ~0.8 each.
- Tangibles is the dimension of service quality that is the least correlated 
with the perceived overall service quality, with a correlation of < 0.5.
*/


/* Question 6 */
ods noproctitle;
ods graphics / imagemap=on;

proc corr data=NATIONAL.NATIONAL pearson fisher (alpha=0.05 rho0=0 type=twosided) nosimple noprob plots=none;
	var rec;
	with oq;
run;

ods noproctitle;

proc freq data=NATIONAL.NATIONAL;
	tables  (sex mstat age inc ed) *(rec) / chisq nocum plots(only)=(freqplot 
		mosaicplot);
run;

/* Conclusion:
- There is a strong, negative, and significant relationship between 
customers’ willingness to recommend National Insurance Company and 
their overall service quality perception. Because “yes” is coded as 1 
and “no” is coded as 2, the lower the overall service quality perception, 
the less likely the customers will recommend National Insurance Company 
to their friends.
- Education variable is related to willingness to recommend 
National Insurance Company because its chi-square test has a probability 
of < 0.05. Less educated people who achieved at most high school education 
or less are more likely to recommend the company to their friends. 
More educated people who achieved at most graduate school education are 
less likely to recommend the company to their friends.
*/