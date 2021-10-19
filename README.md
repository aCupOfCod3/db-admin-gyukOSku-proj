# Project Overview:


  ![](/images/WINWORD_wtr9sfRMku.png)

gyukOSku is a new established all you can eat barbeque restaurant in Jakarta. As time goes by, the owner needs detailed information about the meat information and customers to estimate shop’s income. The owner is planning to build a DBMS to support their business activity. As a Database Administrator you are asked to make these following tasks (using Microsoft SQL Server):

- Create a new job with the following detail:

![](/images/WINWORD_rN5FrAY4O4.png)

- Create a stored procedure named **“DeleteMeat”** to delete data in **Meat** table in accordance with the **MeatId** inputted by user. The stored procedure parameter is **MeatId**. Validate **MeatId** inputted by the user must not exists in **TransactionDetail table**. If it exists, then show **“Meat that has been bought cannot be deleted”** message and no row will be deleted. Otherwise, delete that data and show **“Selected meat has been removed” message**.

  **Display before the stored procedure is executed:**

  ![](/images/WINWORD_lrtY2E86s3.png)

  **Display after the stored procedure is executed:**
  ![](/images/WINWORD_eXriEy3Rln.png)

  **Display if the MeatId exists:**
  
  ![](/images/WINWORD_wKl4jwzajM.png)
  
 - Create a stored procedure named **“TransactionHistory”** that contains a cursor to display the list of transaction history in “gyukOSku” database for the selected **TransactionId**. 
   - Each time the stored procedure is executed, it will display the **TransactionDate**, **CustomerName**, and **CustomerEmail** according to **TransactionId** inputted by user. 
   - It will also display the details of the Transaction, including **MeatName**, **MeatPrice**, **Qty**, and **TotalPrice (obtained from multiplication of each MeatPrice and Quantity from Transactions)**. At the end, show **Highest Calory (obtained from maximum of the MeatCalory multiplied by the Quantity of the Transactions)**. Use aggregate to show TotalPrice andHighest Calory. The stored procedure parameter is **TransactionId** and **CustomerId**.
    ![](/images/WINWORD_PzSBxgGIEf.png)
    
    **Display after the stored procedure is executed:**
     ![](/images/WINWORD_41WmTaqNP0.png)

- Create a trigger named “InsertTrigger” to validate data from Meat for every time the user does an insert on the Meat table, validate that the MeatName that will be inserted should not already exists in the Meat table. If it exists, then show “Meat named <inserted MeatName> already exist” message and do not do the insertion. Otherwise, show “Successfully inserted meat” and proceed to insert the meat.
  
  **Display after the trigger is executed and meat name already exists:**
    ![](/images/WINWORD_voRgAWhlr5.png)

