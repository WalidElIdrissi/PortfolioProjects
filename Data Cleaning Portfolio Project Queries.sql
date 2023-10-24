/*

Cleaning Data in SQL Queries

*/


Select *
From PortfolioProject.dbo.FIFA2022


--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select TransferDate, CONVERT(Date,TransferDate)
From PortfolioProject.dbo.FIFA2022


Update FIFA2022
SET TransferDate = CONVERT(Date,TransferDate)


--------------------------------------------------------------------------------------------------------------------------


-- Breaking out Address into Individual Columns (Address, City, State)


Select ClubAddress
From PortfolioProject.dbo.FIFA2022

SELECT 
    PARSENAME(REPLACE(ClubAddress, ',', '.'), 4)
    PARSENAME(REPLACE(ClubAddress, ',', '.'), 3)
    PARSENAME(REPLACE(ClubAddress, ',', '.'), 2)
    PARSENAME(REPLACE(ClubAddress, ',', '.'), 1)
FROM dbo.FIFA2022;

ALTER TABLE FIFA2022
Add ClubSplitStreet Nvarchar(255);

Update FIFA2022
SET ClubSplitStreet = PARSENAME(REPLACE(ClubAddress, ',', '.') , 4)


ALTER TABLE FIFA2022
Add ClubSplitCity Nvarchar(255);

Update FIFA2022
SET ClubSplitCity = PARSENAME(REPLACE(ClubAddress, ',', '.') , 3)


ALTER TABLE FIFA2022
Add ClubSplitState Nvarchar(255);

Update FIFA2022
SET ClubSplitState = PARSENAME(REPLACE(ClubAddress, ',', '.') , 2)


ALTER TABLE FIFA2022
Add ClubSplitCountry Nvarchar(255);

Update FIFA2022
SET ClubSplitCountry = PARSENAME(REPLACE(ClubAddress, ',', '.') , 1)


--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Transfer as Free Player" field


Select TransferAsFreePlayer
, CASE When TransferAsFreePlayer = 'Y' THEN 'Yes'
	   When TransferAsFreePlayer = 'N' THEN 'No'
	   ELSE TransferAsFreePlayer
	   END
From PortfolioProject.dbo.FIFA2022;


Update FIFA2022
SET TransferAsFreePlayer = CASE When TransferAsFreePlayer = 'Y' THEN 'Yes'
	   When TransferAsFreePlayer = 'N' THEN 'No'
	   ELSE TransferAsFreePlayer
	   END


-----------------------------------------------------------------------------------------------------------------------------------------------------------


-- Remove Duplicates

SELECT DISTINCT *
FROM PortfolioProject.dbo.FIFA2022;