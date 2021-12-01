## Introduction

* The main view of the app is built in a simple UIViewController, which includes a header label `trips` and a content container `flightsView`. 
* The container holds a scrollable `FlightList` and a detailed `TicketView`.
* The `FlightList` contains all the flights information displayed in a list of `FlightCard`
* The `FlightCard` list is sorted and grouped by flight departure date.
* Tap on each `FlightCard` to hide the list and show a `TicketView`.
* Swipe on the left screen edge to dismiss the `TicketView`.

## Challenges
* Adding shadow for the TicketView is a bit tricky. I tried to use the border shape layer as the mask and drop shadow around it, but the shadow was clipped by the mask. So I added the border shape and the shadow as sublayers.
* To clip the round corners of the ticket header, I tried to use `clipToBounds` but it also clipped the shadow around the whole view. So I added a round corner layer mask to the subview.