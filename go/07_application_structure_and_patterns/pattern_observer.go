package main
import "fmt"

/*
Observer Pattern is useful for:
- multiple components need to react to an event or state change
- decoupling the event emitter from the listeners

✅ Loosely coupled components
✅ Easy to extend without modifying existing code
*/

// Observer interface
type Observer interface {
    Update(string)
}

// Subject interface
type Subject interface {
    Register(Observer)
    Notify(string)
}

// EventManager struct
type EventManager struct {
    observers []Observer
}

func (e *EventManager) Register(o Observer) {
    e.observers = append(e.observers, o)
}

func (e *EventManager) Notify(event string) {
    for _, o := range e.observers {
        o.Update(event)
    }
}

// User struct (Observer)
type User struct {
    Name string
}

func (u *User) Update(event string) {
    fmt.Println(u.Name, "received event:", event)
}

func observer_pattern() {
    manager := &EventManager{}
    user1 := &User{Name: "Alice"}
    user2 := &User{Name: "Bob"}

    manager.Register(user1)
    manager.Register(user2)

    manager.Notify("New Product Launch!")
}
