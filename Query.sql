--	Nama	: Dionisius
--	Kelas	: BG01
--	NIM		: 2301930910

use gyukOSku

--1.job_step
SELECT a.MeatId,a.MeatName,c.TransactionDate,CAST(COUNT(c.TransactionId)AS varchar) + ' time(s)' AS [Purchase Amount]
FROM Meat a join DetailTransaction b ON a.MeatId=b.MeatId join HeaderTransaction c ON b.TransactionId=c.TransactionId
GROUP BY a.MeatId,a.MeatName,c.TransactionDate

--2.Create a stored procedure named “DeleteMeat” to delete data in Meat table in accordance with the MeatId inputted by user. The stored procedure parameter is MeatId. Validate MeatId inputted by the user must not exists in TransactionDetail table. If it exists, then show “Meat that has been bought cannot be deleted” message and no row will be deleted. Otherwise, delete that data and show “Selected meat has been removed” message.

go
create proc DeleteMeat @inputId char(5)
as
	IF(EXISTS(Select * from DetailTransaction where MeatId=@inputId))
		BEGIN
		PRINT 'Meat that has been bought cannot be deleted'
		END
	ELSE
		BEGIN
			Delete 
			from Meat
			where MeatId = @inputId
			print 'Selected meat has been removed'
		END

		EXEC DeleteMeat 'MT006'
		SELECT * FROM Meat WHERE MeatId ='MT006'
		EXEC DeleteMeat 'MT005'

--3.Create a stored procedure named “TransactionHistory” that contains a cursor to display the list of transaction history in “gyukOSku” database for the selected TransactionId. 
--i.	Each time the stored procedure is executed, it will display the TransactionDate, CustomerName, and CustomerEmail according to TransactionId inputted by user. 
--ii.	It will also display the details of the Transaction, including MeatName, MeatPrice, Qty, and TotalPrice (obtained from multiplication of each MeatPrice and Quantity from Transactions). At the end, show Highest Calory (obtained from maximum of the MeatCalory multiplied by the Quantity of the Transactions). Use aggregate to show TotalPrice and Highest Calory. The stored procedure parameter is TransactionId and CustomerId.

go
create proc TransactionHistory @transId char(5)
as
DECLARE historyCur Cursor FORWARD_ONLY
for
Select a.CustomerName,a.CustomerEmail,b.TransactionDate,d.MeatName,d.MeatPrice,c.Qty,sum(d.MeatPrice*c.Qty) as [totalPrice],
(select  max(d.MeatCalory*c.Qty)
from  Customer a join HeaderTransaction b on a.CustomerId=b.CustomerId join DetailTransaction c on b.TransactionId=c.TransactionId join Meat d on c.MeatId=d.MeatId
where b.TransactionId=@transId
)as [Highest Calory]
from Customer a join HeaderTransaction b on a.CustomerId=b.CustomerId join DetailTransaction c on b.TransactionId=c.TransactionId join Meat d on c.MeatId=d.MeatId
where b.TransactionId=@transId
group by a.CustomerName,a.CustomerEmail,b.TransactionDate,d.MeatName,d.MeatPrice,c.Qty
open historyCur
declare @name varchar(30),@email varchar(50),@date date,@meatName varchar(30),@price int,@qty int,@totalprice int,@highest int
fetch next from historyCur into @name,@email,@date,@meatName,@price,@qty,@totalprice,@highest
print 'Name		: '+@name
print 'Email		: '+@email
print 'Date		: '+cast(@date as varchar)
print 'Transaction History'
print '----------------------------------------'
	WHILE @@FETCH_STATUS=0
		BEGIN
		PRINT @meatName + ' ('+ cast(@qty as varchar)+'x' + ') '+'Rp. '+cast(@totalprice as varchar)
		fetch next from historyCur into @name,@email,@date,@meatName,@price,@qty,@totalprice,@highest
		END
Print 'Highest Calory: '+cast(@highest as varchar)
close historyCur
deallocate historyCur

EXEC TransactionHistory 'TR001'

--4.	Create a trigger named “InsertTrigger” to validate data from Meat for every time the user does an insert on the Meat table, validate that the MeatName that will be inserted should not already exists in the Meat table. If it exists, then show “Meat named <inserted MeatName> already exist” message and do not do the insertion. Otherwise, show “Successfully inserted meat” and proceed to insert the meat.

go
create trigger InsertTrigger on Meat
instead of insert
as
DECLARE @id char(5),@name varchar(30),@price int,@calory int,@weight int,@rating int

SELECT @id = ins.MeatId FROM INSERTED ins;
SELECT @name = ins.MeatName FROM INSERTED ins;
SELECT @price = ins.MeatPrice FROM INSERTED ins;
SELECT @calory = ins.MeatCalory FROM INSERTED ins;
SELECT @weight = ins.MeatWeight FROM INSERTED ins;
SELECT @rating = ins.MeatRating FROM INSERTED ins;
	IF(exists(select * from Meat where MeatName=@name))
		BEGIN
		PRINT 'Meat named '+ @name + ' already exist'
		END
	
	ELSE
		BEGIN
		Insert into Meat(MeatId,MeatName,MeatPrice,MeatCalory,MeatWeight,MeatRating) values (@id,@name,@price,@calory,@weight,@rating)
		PRINT 'Successfully inserted meat'
		End


