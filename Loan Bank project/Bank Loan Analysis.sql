select * from Bank_Loan_Data

/* total loan applications*/ 
SELECT COUNT(id) as MTD_Total_LoanApplications
from Bank_Loan_Data
where MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

/*total loan applications in previous month*/
SELECT COUNT(id)  AS PMTD_Total_LoanApplications
from Bank_Loan_Data
where MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

/* Total funded amount*/
select sum(loan_amount)  as MTDTotal_Funded_Amount
from Bank_Loan_Data
where MONTH(issue_date) = 12 AND YEAR(issue_date)=2021

select sum(loan_amount)  as PMTDTotal_Funded_Amount
from Bank_Loan_Data
where MONTH(issue_date) = 11 AND YEAR(issue_date)=2021 

/* total amount recivied*/

select SUM(total_payment) as MTD_Total_Amount_recivied
from Bank_Loan_Data 
where  MONTH(issue_date) = 12 AND YEAR(issue_date)=2021          


select SUM(total_payment) as PMTD_Total_Amount_recivied
from Bank_Loan_Data 
where  MONTH(issue_date) = 11 AND YEAR(issue_date)=2021  

/* Average Interest Rate */
select ROUND(AVG(int_rate),4) * 100 as MTD_Average_Interest_Rate
from Bank_Loan_Data
where  MONTH(issue_date) = 12 AND YEAR(issue_date)=2021  

select ROUND(AVG(int_rate),4) * 100 as PMTD_Average_Interest_Rate
from Bank_Loan_Data
where  MONTH(issue_date) = 11 AND YEAR(issue_date)=2021  



/* Averge DTI */

SELECT ROUND (AVG(dti),4) *100 as MTD_Avg_DTI 
FROM Bank_Loan_Data
where  MONTH(issue_date) = 12 AND YEAR(issue_date)=2021  


SELECT ROUND (AVG(dti),4) *100 as PMTD_Avg_DTI 
FROM Bank_Loan_Data
where  MONTH(issue_date) = 11 AND YEAR(issue_date)=2021  

/*Good loan applicato]ion percentage */ 
select 
      (count (case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
	  / count(id) as Good_Loan_Percentage  
FROM Bank_Loan_Data

/*Good loan Application */

select count (id) as Good_Loan_Application
from Bank_Loan_Data
where loan_status = 'Fully Paid' or loan_status = 'Current'

/*Good loan funded Amount */ 
select sum(loan_amount) as Good_Loan_FundedAmount
from Bank_Loan_Data
where loan_status = 'Fully Paid' or loan_status = 'Current'

/*Good Loan Total Received Amount*/ 
select sum(total_payment) as Good_Loan_Received_Amount
from Bank_Loan_Data
where loan_status = 'Fully Paid' or loan_status = 'Current'

 /* bad loans appplications percentage */ 
 select (count (case when loan_status = 'Charged Off' THEN id end ) *100.0) / count (id) as Bad_Loan_Percentage
 from Bank_Loan_Data

 /* Bad loan applicatins */
 select count (id) as Bad_Loan_Applications 
  from Bank_Loan_Data 
  where loan_status = 'Charged Off'

/* Bad loan funded amount */
 select SUM (loan_amount)  as Bad_Loan_FundedAmount 
  from Bank_Loan_Data 
  where loan_status = 'Charged Off'

/*Bad Loan Total Received Amount*/ 
 select SUM (total_payment)  as Bad_Loan_ReceivedAmount 
  from Bank_Loan_Data 
  where loan_status = 'Charged Off'


/* Loan status grid view */ 
select loan_status , 
       count (id) as Total_Application,
	   SUM(loan_amount) as Total_fundedAmount,
	   sum(total_payment) as total_receivrd_amount,
	   avg(int_rate*100) as interest_rate ,
	   avg(dti*100) as DTI 

from Bank_Loan_Data
GROUP BY loan_status

/**/
select loan_status , 
       
	   SUM(loan_amount) as MT_Total_funded_Amount,
	   sum(total_payment) as MTD_Total_Receivrd_Amount
from Bank_Loan_Data
where MONTH(issue_date) = 12
GROUP BY loan_status

/*Monthly Trends by Issue Date */ 
select MONTH(issue_date) as month_num,
       DATENAME(MONTH,issue_date) AS Month_Name ,
       count (id) as Total_Loan_Application,
       sum(loan_amount) as Total_funded_Amount,
	   sum(total_payment) as Total_Receivrd_Amount

from Bank_Loan_Data
GROUP BY  MONTH(issue_date) ,DATENAME(MONTH,issue_date)
order by MONTH(issue_date)

/* Regional Analysis by State*/ 
select address_state,
       count (id) as Total_Loan_Application,
       sum(loan_amount) as Total_funded_Amount,
	   sum(total_payment) as Total_Receivrd_Amount

from Bank_Loan_Data
GROUP BY  address_state
order by Total_funded_Amount desc 


/* Loan term analysis */
select term,
       count (id) as Total_Loan_Application,
       sum(loan_amount) as Total_funded_Amount,
	   sum(total_payment) as Total_Receivrd_Amount

from Bank_Loan_Data
GROUP BY  term
order by term desc 

/* Employee Length Analysis*/
select emp_length,
       count (id) as Total_Loan_Application,
       sum(loan_amount) as Total_funded_Amount,
	   sum(total_payment) as Total_Receivrd_Amount

from Bank_Loan_Data
GROUP BY  emp_length
order by Total_Loan_Application desc

/* Loan Purpose Breakdown  */
select purpose,
       count (id) as Total_Loan_Application,
       sum(loan_amount) as Total_funded_Amount,
	   sum(total_payment) as Total_Receivrd_Amount

from Bank_Loan_Data
GROUP BY  purpose
order by Total_Loan_Application desc

/* Home Ownership Analysis */
select home_ownership,
       count (id) as Total_Loan_Application,
       sum(loan_amount) as Total_funded_Amount,
	   sum(total_payment) as Total_Receivrd_Amount

from Bank_Loan_Data
where grade = 'A' and address_state = 'CA'
GROUP BY  home_ownership
order by Total_Loan_Application desc

