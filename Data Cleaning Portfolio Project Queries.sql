/*

Cleaning Data in SQL Queries

*/


Select *
From PortfolioProject.dbo.SuperstoreSales


--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select OrderDate, CONVERT(Date,OrderDate)
From PortfolioProject.dbo.SuperstoreSales


Update SuperstoreSales
SET OrderDate = CONVERT(Date,OrderDate)


--------------------------------------------------------------------------------------------------------------------------


-- Breaking out Address into Individual Columns (Address, City, Country)


Select ShippingAddress
From PortfolioProject.dbo.SuperstoreSales

SELECT 
    PARSENAME(REPLACE(ShippingAddress, ',', '.'), 3),
    PARSENAME(REPLACE(ShippingAddress, ',', '.'), 2),
    PARSENAME(REPLACE(ShippingAddress, ',', '.'), 1)
FROM dbo.SuperstoreSales;

ALTER TABLE SuperstoreSales
Add ShippingAddressSplitStreet Nvarchar(255);

Update SuperstoreSales
SET ShippingAddressSplitStreet = PARSENAME(REPLACE(ShippingAddress, ',', '.') , 3)


ALTER TABLE SuperstoreSales
Add ShippingAddressSplitCity Nvarchar(255);

Update SuperstoreSales
SET ShippingAddressSplitCity = PARSENAME(REPLACE(ShippingAddress, ',', '.') , 2)


ALTER TABLE SuperstoreSales
Add ShippingAddressSplitState Nvarchar(255);

Update SuperstoreSales
SET ShippingAddressSplitState = PARSENAME(REPLACE(ShippingAddress, ',', '.') , 1)



--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "ProductReturn" field


Select ProductReturn
, CASE When ProductReturn = 'Y' THEN 'Yes'
	   When ProductReturn = 'N' THEN 'No'
	   ELSE ProductReturn
	   END
From PortfolioProject.dbo.SuperstoreSales;


Update SuperstoreSales
SET ProductReturn = CASE When ProductReturn = 'Y' THEN 'Yes'
	   When ProductReturn = 'N' THEN 'No'
	   ELSE ProductReturn
	   END


-----------------------------------------------------------------------------------------------------------------------------------------------------------


-- Remove Duplicates

SELECT DISTINCT *
FROM PortfolioProject.dbo.SuperstoreSales;