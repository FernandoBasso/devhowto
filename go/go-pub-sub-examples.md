---
description: Some examples and ideas on how to implement simple pub/sub, listener/notifier pattern in Go.
---

# Go Pub Sub Examples

## Example 1

Saw this [StackOverflow question](https://stackoverflow.com/questions/35648561/how-to-store-functions-in-a-slice-in-go) and decided to try my hand a quick translation of that Python implementation using Go interfaces, structs and methods.

```{code} go
:filename: main.go
:caption: Simple pub/sub implementation in Go
package main

import "fmt"

// Subscriber provides a callback function that the dispatcher
// can use to notify the subscriber.
type Subscriber interface {
  Callback()
}

// SubscriberImpl simply works with a string message for this example.
type SubscriberImpl struct {
  Message string
}

// Callback simply prints the message.
func (s *SubscriberImpl) Callback() {
  fmt.Println("Message: " + s.Message)
}

// Dispatcher is responsible for registering subscribers
// and notifying them.
type Dispatcher interface {
  Register(Subscriber)
  Notify()
}

// DispatcherImpl contains a slice of subscribers.
type DispatcherImpl struct {
  Subscribers []Subscriber
}

// Register registers a subscriber with the dispatcher.
func (d *DispatcherImpl) Register(subscriber Subscriber) {
  d.Subscribers = append(d.Subscribers, subscriber)
}

// Notify loops over all of the subscribers and call their
// Callback() function so they can react however they want.
func (d *DispatcherImpl) Notify() {
  for _, subscriber := range d.Subscribers {
    subscriber.Callback()
  }
}

// Drive code to do a simple check.
func main() {
  beeper := SubscriberImpl{Message: "beep beep"}
  pinger := SubscriberImpl{Message: "ping ping"}

  dispatcher := DispatcherImpl{}
  dispatcher.Register(&beeper)
  dispatcher.Register(&pinger)

  dispatcher.Notify()
}
```

```{code} bash
:filename: bash session
:caption: Sample output
$ go run ./main.go 
Message: beep beep
Message: ping ping
```
