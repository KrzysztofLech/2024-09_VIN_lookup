# VIN Search Challenge
September 2024


## Task description:
Build an app that fetches data about particular vehicle identified by VIN number using VIN Lookup
API. The UI, UX and implementation details are at the discretion of the candidate.
You can use any architecture or third party dependencies as you choose.

## VIN input screen:
The main screen of the app should contain an input for the VIN number and ‘Search’ button. Text
input is a must, but you can also add another way of input you believe would be more useful for
the user. Input should be validated before API request is sent.

## Vehicle information screen
Received information should be presented on a modal or overlay screen that can be easily closed.
Set of details should include: *wmi, vds, vis, country, region, year* and *VIN* as a title.

## Recent searches list
As filling in VIN may be cumbersome for the user, there should be a list of recent searches stored,
easily available for later use.

## Additional requirements:
* Input field with validation and vehicle lookup feature should be easily reusable in other apps
* Provide an alternative way to enter the VIN number
* Assume that service has rate limiting enabled and allows for maximum 10 requests per minute
* Prepare app for longer loading times and errors that can be received

## Public API
VIN lookup can be accessed through Ninjas API, documentation:
[https://api-ninjas.com/api/vinlookup]()

## Sample VIN numbers
* JT3HP10VXW7092383
* 4TARN13P1SZ314855
* JTDKN3DU6C1423122
* KMHDN45D32D464848