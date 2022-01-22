# UsedCarListings
A sample app to list used cars

### UI
![Simulator Screen Shot - iPod touch (7th generation) - 2022-01-21 at 23 18 12](https://user-images.githubusercontent.com/47827901/150624393-66ba466d-2dc6-41c7-84fb-59c9c229c31d.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-01-21 at 23 18 16](https://user-images.githubusercontent.com/47827901/150624394-fe8aa106-9557-4857-8ee7-af10b96ffebc.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-01-21 at 23 18 19](https://user-images.githubusercontent.com/47827901/150624395-cf116785-1793-4de9-a332-9ce01e8940f4.png)
![Simulator Screen Shot - iPod touch (7th generation) - 2022-01-21 at 23 18 22](https://user-images.githubusercontent.com/47827901/150624396-4c5572c9-8f87-4275-890f-ee9e394e8072.png)

### Architecture

## MVVM


## Features

- UsedCarListings:

This view shows a list of used car listings fetching from a sample json. 
The view model uses Combine publisher subscribe mechansim to let view know about the data fetch events and update view when data is downloaded

- FilterView:

This view has two basic filter types
1- Filter by price
2- Filter by mileage

When one of type is selected, this view sends out a notification with the type selected, and the previous view model listens to the notification and updates the used cars list based on the filter selected


## Services

- UsedCarService

This is responsible for fetching used cars data

- ImageLoader

This is responsible for loading imaged from a url

## AppEnvironment

This implements two protocols. 
1- Environment

A single point of access for shared services like USedCarService and ImageLoader

2- AppFactory

This implements a factory pattern to build views for the app.
