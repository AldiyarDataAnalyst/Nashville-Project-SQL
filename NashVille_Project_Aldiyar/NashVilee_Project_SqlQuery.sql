--Select SaleDate, Convert(Date, SaleDate) as NewDate
--From PortfolioProjectAldiyar..NashvilleHousing 

--ALTER TABLE NashvilleHousing
--Add SaleDateConverted date ;

--Update NashvilleHousing
--Set SaleDateConverted = Convert(Date, SaleDate) 


--Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
--From PortfolioProjectAldiyar..NashvilleHousing a
--join PortfolioProjectAldiyar..NashvilleHousing b 
--     on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress is null 


--Update a
--Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
--From PortfolioProjectAldiyar..NashvilleHousing a
--join PortfolioProjectAldiyar..NashvilleHousing b 
--     on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
--Where a.PropertyAddress is null 

--Select SUBSTRING(PropertyAddress, 1, Charindex(',',PropertyAddress) -1) as Address, SUBSTRING(PropertyAddress, Charindex(',',PropertyAddress) +1, Len(PropertyAddress)) 
--From NashvilleHousing


--ALTER TABLE NashvilleHousing
--Add PropertySplitAddress nvarchar(255) ;

--Update NashvilleHousing
--Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, Charindex(',',PropertyAddress) -1)

--ALTER TABLE NashvilleHousing
--Add PropertySplitCity nvarchar(255) ;

--Update NashvilleHousing
--Set PropertySplitCity = SUBSTRING(PropertyAddress, Charindex(',',PropertyAddress) +1, Len(PropertyAddress))

--Select OwnerAddress
--From NashvilleHousing

--Select
--PARSENAME(Replace(OwnerAddress, ',','.'),3),
--PARSENAME(Replace(OwnerAddress, ',','.'),2),
--PARSENAME(Replace(OwnerAddress, ',','.'),1)
--From NashvilleHousing




--ALTER TABLE NashvilleHousing
--Add OwnerSplitAddress nvarchar(255) ;

--Update NashvilleHousing
--Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',','.'),3)


--ALTER TABLE NashvilleHousing
--Add OwnerSplitCity nvarchar(255) ;

--Update NashvilleHousing
--Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',','.'),2)


--ALTER TABLE NashvilleHousing
--Add OwnerSplitState nvarchar(255) ;

--Update NashvilleHousing
--Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',','.'),1)

Select *
From dbo.NashvilleHousing


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant


Select SoldAsVacant,
Case   When SoldAsVacant= 'Y' then 'Yes'
       When SoldAsVacant= 'N' then 'No'
	   Else SoldAsVacant
	   End
From NashvilleHousing


Update NashvilleHousing
Set SoldAsVacant =
Case When SoldAsVacant= 'Y' then 'Yes'
       When SoldAsVacant= 'N' then 'No'
	   Else SoldAsVacant
	   End


--Select * 
--from NashvilleHousing


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProjectAldiyar..NashvilleHousing
)
Delete
From RowNumCTE
Where row_num > 1


Select * 
From PortfolioProjectAldiyar..NashvilleHousing
order by 1 desc


ALTER TABLE PortfolioProjectAldiyar.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

