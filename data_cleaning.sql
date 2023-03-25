USE nashville_housing;

/*
Cleaning Data in SQL Queries
*/

SELECT *
FROM nashville_housing;

#-------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format

ALTER TABLE nashville_housing
ADD SaleDateConverted DATE;

UPDATE nashville_housing
SET SaleDateConverted = STR_TO_DATE(SaleDate,'%Y-%m-%d');

ALTER TABLE nashville_housing
DROP COLUMN  SaleDate;

-- Turn all the empty cells into NULL and convert them in the correct format if necessary

UPDATE nashville_housing
SET PropertyAddress = NULL
WHERE PropertyAddress = '';

UPDATE nashville_housing
SET SalePrice = REPLACE(SalePrice, ',', ''), SalePrice = REPLACE(SalePrice, '$', '');

ALTER TABLE nashville_housing 
CHANGE COLUMN SalePrice SalePrice INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET OwnerName = NULL
WHERE OwnerName  = '';

UPDATE nashville_housing
SET OwnerAddress = NULL
WHERE OwnerAddress = '';

UPDATE nashville_housing
SET Acreage = NULL
WHERE Acreage = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN Acreage Acreage DECIMAL(5,2) NULL DEFAULT NULL ;

UPDATE nashville_housing
SET TaxDistrict = NULL
WHERE TaxDistrict = '';

UPDATE nashville_housing
SET LandValue = NULL
WHERE LandValue = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN LandValue LandValue INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET BuildingValue = NULL
WHERE BuildingValue = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN BuildingValue BuildingValue INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET TotalValue = NULL
WHERE TotalValue = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN TotalValue TotalValue INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET YearBuilt = NULL
WHERE YearBuilt = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN YearBuilt YearBuilt INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET Bedrooms = NULL
WHERE Bedrooms = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN Bedrooms Bedrooms INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET FullBath = NULL
WHERE FullBath = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN FullBath FullBath INT NULL DEFAULT NULL ;

UPDATE nashville_housing
SET HalfBath = NULL
WHERE HalfBath = '';

ALTER TABLE nashville_housing 
CHANGE COLUMN HalfBath HalfBath INT NULL DEFAULT NULL ;

#------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)
-- PropertyAddress

SELECT PropertyAddress
FROM nashville_housing;

SELECT
	SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1 ) AS Address,
    SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1 , LENGTH(PropertyAddress)) AS Address
FROM nashville_housing;


ALTER TABLE nashville_housing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE nashville_housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) -1 );

ALTER TABLE nashville_housing
ADD PropertySplitCity NVARCHAR(255);

UPDATE nashville_housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1 , LENGTH(PropertyAddress));

SELECT *
FROM nashville_housing;

-- OwnerAddress

SELECT OwnerAddress
FROM nashville_housing;

SELECT
  SUBSTRING_INDEX(OwnerAddress,',', 1) AS OwnerSplitAddress,
  SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),' ', -1) AS OwnerSplitCity, 
  SUBSTRING_INDEX(OwnerAddress,',', -1) AS OwnerSplitState
FROM nashville_housing;


ALTER TABLE nashville_housing
ADD OwnerSplitAddress NVARCHAR(255),
ADD OwnerSplitCity NVARCHAR(255),
ADD OwnerSplitState NVARCHAR(255);

UPDATE nashville_housing
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress,',', 1); 

UPDATE nashville_housing
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2),' ', -1);

UPDATE nashville_housing
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress,',', -1);


SELECT *
FROM nashville_housing;

#--------------------------------------------------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT (SoldAsVacant), COUNT(SoldAsVacant)
FROM nashville_housing
GROUP BY SoldAsVacant
ORDER BY 2;


SELECT COUNT(SoldAsVacant),
    (CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END) AS result
FROM nashville_housing
GROUP BY result
ORDER BY 1;


UPDATE nashville_housing 
SET SoldAsVacant = CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;

-- Change 'VACANT RES LAND', and 'VACANT RESIENTIAL LAND' to 'VACANT RESIDENTIAL LAND' in "Land Use" field

SELECT DISTINCT (LandUse), COUNT(LandUse)
FROM nashville_housing
GROUP BY LandUse
ORDER BY 2 DESC;

SELECT COUNT(LandUse),
    (CASE
        WHEN LandUse = 'VACANT RES LAND'  THEN 'VACANT RESIDENTIAL LAND'
        WHEN LandUse = 'VACANT RESIENTIAL LAND' THEN 'VACANT RESIDENTIAL LAND'
        ELSE LandUse
    END) AS result
FROM nashville_housing
GROUP BY result
ORDER BY 1 DESC;

UPDATE nashville_housing 
SET LandUse = CASE
        WHEN LandUse = 'VACANT RES LAND'  THEN 'VACANT RESIDENTIAL LAND'
        WHEN LandUse = 'VACANT RESIENTIAL LAND' THEN 'VACANT RESIDENTIAL LAND'
        ELSE LandUse
    END;
#-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates

SELECT * 
FROM 
(
	SELECT *,
	ROW_NUMBER() OVER 
    (
		PARTITION BY 
			ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDateConverted,
			LegalReference
		ORDER BY UniqueID
	) AS row_num
	FROM nashville_housing
) t
WHERE  row_num > 1
ORDER BY PropertyAddress;

DELETE FROM nashville_housing 
WHERE UniqueID IN 
(
	SELECT UniqueID
	FROM 
	(
		SELECT *,
		ROW_NUMBER() OVER 
		(
			PARTITION BY 
				ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDateConverted,
				LegalReference
			ORDER BY UniqueID
		) AS row_num
		FROM nashville_housing
	) t
	WHERE  row_num > 1
);

#---------------------------------------------------------------------------------------------------------
-- Delete Unused Columns

SELECT *
FROM nashville_housing;

ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress, 
DROP COLUMN PropertyAddress;

#-----------------------------------------------------------------------------------------------