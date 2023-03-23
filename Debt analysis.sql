/*The act of taking on debt is not limited to individuals managing their own expenses. 
     Countries may also borrow money to support their economy, such as for investing in infrastructure that improves citizens' quality of life. 
     The World Bank is an organization that offers loans to developing countries to support these kinds of initiatives.
     In this project, we will be examining data on international debt collected by The World Bank. 
     The dataset provides information on the amount of money (in USD) owed by developing countries across various categories. 
     Through our analysis, we aim to answer questions such as:
     1. What is the total amount of debt for all the countries in the dataset?
     2. Which country has the largest debt amount and what is that amount?
     3. How does the average debt amount owed by countries vary across different debt indicators?
*/

--1. Lets collect first 10 records 

     SELECT TOP 10 * 
     FROM dbo.internatdebt     
     ORDER BY country_name

--2. Finding the number of distinct countries
     /*The first ten rows of the dataset show the debt owed by Afghanistan across various debt indicators.
     However, we cannot determine the total number of unique countries included in the table due to 
     the possibility of repeated country names resulting from a country having debt in multiple debt indicators.
     Without this information, we will be unable to conduct a comprehensive statistical analysis. 
     Thus, in this section, we will extract the count of unique countries represented in the dataset.*/

     SELECT COUNT(DISTINCT(country_name)) AS total_distinct_countries 
     FROM dbo.internatdebt;

--3. Finding out the distinct debt indicators
     /*The table contains information about 124 countries and their debt indicators. 
     The column "indicator_name" provides a brief description of the purpose of the debt, 
     while the column "indicator_code" indicates the category of the debt. 
     Understanding these debt indicators can provide insight into the specific areas in which a country may have borrowed money.*/

     SELECT DISTINCT(indicator_code) AS distinct_debt_indicators
     FROM dbo.internatdebt
     ORDER BY distinct_debt_indicators;

--4. Totaling the amount of debt owed by the countries
     /*Moving away from the discussion of debt indicators of individual countries, 
     let's focus on the global perspective. We can determine the total amount of debt (measured in USD) owed by all countries, 
     which will provide an indication of the overall state of the global economy.*/

     SELECT ROUND((SUM(debt)/1000000),2) as total_debt
     FROM dbo.internatdebt;

--5. Country with the highest debt
     /*Now that we have the exact total of the amounts of debt owed by several countries, 
     let's now find out the country that owns the highest amount of debt along with the amount. 
     Note that this debt is the sum of different debts owed by a country across several categories. 
     This will help to understand more about the country in terms of its socio-economic scenarios. 
     We can also find out the category in which the country owns its highest debt. But we will leave that for now.*/

     SELECT TOP 1 country_name, SUM(debt) as total_debt
     FROM dbo.internatdebt
     GROUP BY country_name
     ORDER BY total_debt DESC
     
--6. Average amount of debt across indicators
     /*So, it was China. A more in-depth breakdown of China's debts can be found here.
     We now have a brief overview of the dataset and a few of its summary statistics. 
     We already have an idea of the different debt indicators in which the countries owe their debts. 
     We can dig even further to find out on an average how much debt a country owes? 
     This will give us a better sense of the distribution of the amount of debt across different indicators.*/

     SELECT TOP 10 indicator_code , indicator_name, AVG(debt) as average_debt
     FROM dbo.internatdebt
     GROUP BY indicator_code,indicator_name
     ORDER BY average_debt

--7. The highest amount of principal repayments
     /*We can see that the indicator DT.AMT.DLXF.CD tops the chart of average debt. This category includes repayment of long term debts. 
     Countries take on long-term debt to acquire immediate capital. More information about this category can be found here.
     An interesting observation in the above finding is that there is a huge difference in the amounts of the indicators after the second one. 
     This indicates that the first two indicators might be the most severe categories in which the countries owe their debts.
     We can investigate this a bit more so as to find out which country owes the highest amount of debt in the category of long term debts (DT.AMT.DLXF.CD). 
     Since not all the countries suffer from the same kind of economic disturbances, 
     this finding will allow us to understand that particular country's economic condition a bit more specifically.*/

     SELECT country_name, indicator_name
     FROM dbo.internatdebt
     WHERE debt= (SELECT TOP 1 MAX(debt)
     FROM dbo.internatdebt
     WHERE indicator_code = 'DT.AMT.DLXF.CD'
     GROUP BY country_name, indicator_code 
     ORDER BY MAX(debt) DESC)

--8. The most common debt indicator
     /*China has the highest amount of debt in the long-term debt (DT.AMT.DLXF.CD) category. This is verified by The World Bank.
     It is often a good idea to verify our analyses like this since it validates that our investigations are correct.
     We saw that long-term debt is the topmost category when it comes to the average amount of debt. 
     But is it the most common indicator in which the countries owe their debt? Let's find that out.*/

     SELECT indicator_code, COUNT(indicator_code) as indicator_count
     FROM DBO.internatdebt
     GROUP BY indicator_code
     ORDER BY indicator_count DESC, indicator_code DESC

--9. Other viable debt issues and conclusion
     /*There are a total of six debt indicators in which all the countries listed in our dataset have taken debt.
     The indicator DT.AMT.DLXF.CD is also there in the list. So, this gives us a clue that all these countries are suffering from a common economic issue. 
     But that is not the end of the story, but just a part of the story.
     Let's change tracks from debt_indicators now and focus on the amount of debt again. 
     Let's find out the maximum amount of debt that each country has. With this, we will be in a position to identify the other plausible economic issues a country might be going through.
     In this notebook, we took a look at debt owed by countries across the globe. 
     We extracted a few summary statistics from the data and unraveled some interesting facts and figures.
     We also validated our findings to make sure the investigations are correct.*/

     SELECT TOP 10 country_name, MAX(debt) as maximum_debt
     FROM DBO.internatdebt 
     GROUP BY country_name 
     ORDER BY maximum_debt DESC

