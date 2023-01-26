# SQL-Monthly_Recurring_Revenue
The exercise is the following:  
“Imagine you’re working in a database with two tables, "subscriptions" and "creators". You can calculate the monthly recurring revenue (MRR) for a specific creator by simply summarising the "monthly_amount" field of all active subscriptions, according to their "active_from" and "expires_at" dates, with currently active subscriptions having "expires_at" be empty or in the future. Please write two SQL queries: Find out the current MRR for a specific "creator_id", as well as historical end-of-month MRR data for the last 12 months, including the current running month. If you’re not sure, feel free to outline your approach in written form! This is not a coding exercise and there are no bonus points for making it complicated – we’re just interested in finding out how you work.”

## Procedure
In order to tackle the exercise, a **Postgres** database has been created using **pgAdmin4**, and then the following steps have been followed:
1)	A table named “creators” has been created. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/1)%20Create%20'creators'%20table.sql">SQL command</a>  
2)	A table named “subscriptions” has been created. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/2)%20Create%20'subscriptions'%20table.sql">SQL command</a>  
3)	The “creators” table has been populated. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/3)%20Populate%20'creators'%20table.sql">SQL command</a>  
    •	The entries follow this format: (creator_id, project, monthly_amount)  
4)	The “subscriptions” table has been populated. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/4)%20Populate%20'subscriptions'%20table.sql">SQL command</a>  
    •	The entries follow this format: (creator_id, active_from, expires_at)  
    •	The entries have been generated through a Python script. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/Generate%20entries%20for%20PostgreSQL.ipynb">Python script</a>  
5)	Calculate the MRR for the current month for a specific creator. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/5)%20Current%20MRR.sql">SQL command</a>  
    •	The query returns the MRR for creator_id = 5  
    •	The current MRR has been calculated by adding up all the "monthly_amount" fields of all the active subscriptions (i.e. having "expires_at" empty or in the future)  
6)	Calculate the historical end-of-month MRR data for the last 12 months, including the current running month, for a specific creator. See <a href="https://github.com/Luca-Verderio/Steady-SQL_Exercise/blob/main/6)%20Historical%20MRR.sql">SQL command</a>  
    •	The query returns the historical MRR data for the last 12 months for creator_id = 5  
    •	A case statement has been created for each of the last 11 months and the current month  
    •	The MRR for each month has been calculated by adding up all the "monthly_amount" fields of all the subscriptions that were active on the last day of that specific month and for which a payment occurred within that calendar month  
    •	The MRR for the current month refers to the day the query was run (4th of January 2023) rather than the last day of the month

## Assumptions
The following assumptions have been made:
1)	The subscription is assumed to be of two types: monthly or permanent.  
        A monthly subscription lasts exactly 30 days before expiring unless renewed by the user.  
        A permanent subscription lasts forever, and the payment occurs automatically at the beginning of every 30-day period.  

    Example: (4, '2022-01-20 11:09:20', NULL)  
    In this case, a user subscribed to creator_id = 4, the subscription started on '2022-01-20 11:09:20' and the expiration date is NULL (thus the subscription is permanent).  

    Example: (2, '2023-01-01 10:39:55', '2023-01-31 10:39:55')  
    In this case, a user subscribed to creator_id = 2, the subscription started on '2023-01-01 10:39:55' and it expires on '2023-01-31 10:39:55'.
2)	The users renewing the monthly subscription are assumed to make the payment every 30 days, at the beginning of the 30-day period (on the last day of the previous 30-day period)  

    Example: (5, '2022-09-18 14:07:05', '2022-12-17 14:07:05')  
    In this case, the first payment occurred in September, the second in October and the third in November. Then the subscription expired in December and it was no longer renewed. Hence, this subscription won’t be included in the MRR for December.  

    Example: (5, '2022-09-08 17:59:12', NULL)  
    In this case, the first payment occurred in September and then once a month thereafter. Hence, this subscription is included in the MRR for every month after September.  

## Tools
Programming language: **SQL**, **Python**    
RDBMS: **PostgreSQL**  
PostgreSQL management: **pgAdmin**  
Software distribution: **Anaconda**  
Environment: **Jupyter Notebook**  
