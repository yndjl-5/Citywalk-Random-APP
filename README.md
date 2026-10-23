# Taipei CityWalk

## Introduction

Sometimes I want to go outside and explore Taipei, but I don't know where to go. Planning a trip can also take a lot of time. That's why I created **Taipei CityWalk**, an app that helps people discover new places in Taipei in a fun and simple way.

Users can randomly get an MRT line, station, and exit, along with a small walking challenge.

Currently, the app only includes 6 locations, but I hope to add more places and features in the future.

## Features

- **Random Destination:** Randomly selects an MRT line, station, and exit.
- **Walking Challenges:** Each location comes with a small task, such as taking photos or exploring streets.
- **Try Again:** Users can generate another destination without getting the same location twice in a row.
- **Location Information:** Displays the station name, MRT line, exit number, and photo.

## Key Code

The app uses `randomElement()` to randomly select destinations and `filter()` to avoid repeating the previous location.

```swift
private func randomWalk() {
    let choices = walkSpots.filter { $0.id != result?.id }

    let lines = ["淡水信義線", "松山新店線", "板南線",
                 "中和新蘆線", "文湖線"]

    let availableLines = lines.filter { line in
        choices.contains { $0.line == line }
    }

    guard let line = availableLines.randomElement() else { return }

    let stations = choices.filter { $0.line == line }

    guard let station = stations.randomElement(),
          let exit = station.exits.randomElement() else { return }

    result = station
    exitNumber = exit
}
```

## Built With

- Swift
- SwiftUI
- Xcode

## Future Improvements

- Add more MRT stations and destinations.
- Provide more detailed information about each location.
- Add maps and navigation.
- Create more interesting walking challenges.
