// Alloy model for the girls and cars puzzle

// The five girls at fixed positions A-E
abstract sig Girl {
    name: one Name,        // Each girl has a name (Bianca, Franca, etc.)
    owns: one Car,         // Each girl OWNS one car (this is what we need to find)
    wears: one Clothing    // Each girl wears either trousers or skirt
}

// Girls are at fixed positions: A is at position 1, B at position 2, etc.
one sig A, B, C, D, E extends Girl {}

// The five possible names
abstract sig Name {}
one sig Bianca, Franca, Giovanna, Laura, Marta extends Name {}

// The five cars at fixed positions
abstract sig Car {
    hasRoofRack: one Bool
}
one sig Car1, Car2, Car3, Car4, Car5 extends Car {}

// Clothing types
abstract sig Clothing {}
one sig Trousers, Skirt extends Clothing {}

// Boolean for roof rack
abstract sig Bool {}
one sig True, False extends Bool {}

// Fixed facts about the setup
fact FixedSetup {
    // Car 3 and Car 5 have roof racks, others don't
    Car1.hasRoofRack = False
    Car2.hasRoofRack = False
    Car3.hasRoofRack = True
    Car4.hasRoofRack = False
    Car5.hasRoofRack = True
    
    // Girl A and Girl E wear trousers
    A.wears = Trousers
    E.wears = Trousers
    
    // Girls B, C, D wear skirts
    B.wears = Skirt
    C.wears = Skirt
    D.wears = Skirt
}

// Ensure proper assignment
fact Assignment {
    // Each name is assigned to exactly one girl
    all n: Name | one g: Girl | g.name = n
    
    // Each car is owned by exactly one girl
    all c: Car | one g: Girl | g.owns = c
    
    // No girl is initially standing in front of her own car
    // Girl A (position 1) does not own Car1, B does not own Car2, etc.
    A.owns != Car1
    B.owns != Car2
    C.owns != Car3
    D.owns != Car4
    E.owns != Car5
}

// Helper predicate: are two girls standing next to each other?
// Since girls are at fixed positions: A(1), B(2), C(3), D(4), E(5)
// Neighbors are: A-B, B-C, C-D, D-E
pred areNeighbors[g1, g2: Girl] {
    (g1 = A and g2 = B) or (g1 = B and g2 = A) or
    (g1 = B and g2 = C) or (g1 = C and g2 = B) or
    (g1 = C and g2 = D) or (g1 = D and g2 = C) or
    (g1 = D and g2 = E) or (g1 = E and g2 = D)
}

// Girl A's statement:
// "Laura is not next to her, and A's car is now in front of Bianca"
fact GirlA_Statement {
    // Laura is not standing next to Girl A
    all g: Girl | g.name = Laura implies not areNeighbors[A, g]
    
    // A's car is now in front of Bianca
    // This means: The car that A owns is at the position where Bianca is standing
    // Since girls are at fixed positions, if Bianca is at position X, then A owns CarX
    all g: Girl | g.name = Bianca implies 
        (g = A implies A.owns = Car1) and
        (g = B implies A.owns = Car2) and
        (g = C implies A.owns = Car3) and
        (g = D implies A.owns = Car4) and
        (g = E implies A.owns = Car5)
}

// Check to verify that a specific invalid configuration is not allowed
pred InvalidConfiguration {
    // Girl A is named Franca and owns Car1
    A.name = Franca
    A.owns = Car1
    
    // Girl B is named Laura and owns Car2
    B.name = Laura
    B.owns = Car2
}

// Run to find valid configurations with all constraints
run {} for 5 Int

check { not InvalidConfiguration } for 5 Int
