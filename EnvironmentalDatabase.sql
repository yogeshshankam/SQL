--An international NGO is planning to set up offices in various subregions where the Total species count is over 6 thousand and less than 7 thousand to study the impact of Climate changes over different species. But to begin with they are looking for some basic data to help decide on the area of interest.
SQL
With WildLife6K7K AS (
SELECT wlt.SubregionID, sum(wlt.PopulationCount) as TotalPopulationCount
FROM WildlifeTracking wlt
group by wlt.SubregionID
),
LatestClimateData AS (
select cd.StationID, max(cd.RecordID), cd.RecordDate, cd.AverageTemperature
from ClimateData cd
group by cd.StationID
)

Select sr.SubregionID, WL6K7K.TotalPopulationCount, lcd.StationID, lcd.AverageTemperature
From Subregions sr
JOIN MonitoringStations ms ON ms.SubregionID = sr.SubregionID
JOIN LatestClimateData lcd ON lcd.StationID = ms.StationID
JOIN WildLife6K7K WL6K7K ON WL6K7K.SubregionID = sr.SubregionID
where 
WL6K7K.TotalPopulationCount between 6000 and 7000
order by sr.SubregionID, lcd.StationID;
