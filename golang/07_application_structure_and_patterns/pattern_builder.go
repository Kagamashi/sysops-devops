package main
import "fmt"

/*
Builder Pattern helps construct complex objects step by step. 

Useful when:
- the object has many optional fields
- the object construction process is complex

✅ Step-by-step object creation
✅ More readable and maintainable
*/

// House struct with optional fields
type House struct {
    Floors int
    Rooms  int
    Garage bool
}

// HouseBuilder struct
type HouseBuilder struct {
    house House
}

func NewHouseBuilder() *HouseBuilder {
    return &HouseBuilder{}
}

func (b *HouseBuilder) SetFloors(floors int) *HouseBuilder {
    b.house.Floors = floors
    return b
}

func (b *HouseBuilder) SetRooms(rooms int) *HouseBuilder {
    b.house.Rooms = rooms
    return b
}

func (b *HouseBuilder) SetGarage(hasGarage bool) *HouseBuilder {
    b.house.Garage = hasGarage
    return b
}

func (b *HouseBuilder) Build() House {
    return b.house
}

func builder_pattern() {
    house := NewHouseBuilder().SetFloors(2).SetRooms(5).SetGarage(true).Build()
    fmt.Println(house)
}
