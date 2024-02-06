## Download the Birdwatch data for the current day 
using Dates, HTTP
### Get the date of yesterday
data_date = Dates.today()-Day(1)
data_date = Dates.format(data_date, "yyyy/mm/dd")
# Baseurl 
baseurl = "https://ton.twimg.com/birdwatch-public-data/"
# File types
notetypes = ["notes/notes", "noteRatings/ratings", "noteStatusHistory/noteStatusHistory", "userEnrollment/userEnrollment"]
## Format is baseurl/data_date/notetype/notetype-0000$num.csv

"""
# Example usage:
url = "https://ton.twimg.com/birdwatch-public-data/2024/02/05/userEnrollment/userEnrollment-00000.tsv"
file_exists(url)
"""
function file_exists(url::AbstractString)
    try
        response = HTTP.head(url)
        response.status == 200
    catch
        return false
    end
end


for notetype in notetypes
    for i in 0:5
        num = lpad(i, 5, "0")
        url = baseurl * data_date * "/" * notetype * "-" * num * ".tsv"
        if file_exists(url)
            println("YES!" * url)
        else 
            println("NO!" * url)
        end
    end
end