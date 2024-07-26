protocol Base: Base1, Base2{
}

protocol Base1 {
    func calculate(a: Int, b: Int) -> Int
}

protocol Base2 {
    var d: Int { get }
}


extension Base {
    var d: Int {
        get {
            return 4
        }
    }
    func calculate(a: Int, b: Int) -> Int {
        return a + b
    }
}

struct Child: Base {
    var d: Int {
        get {
            return 7
        }
    }
    func calculate(a: Int, b: Int) -> Int {
        return a * b
    }
}

class ChildClass: Base {
    var d: Int {
        get {
            return 3
        }
    }
    func calculate(a: Int, b: Int) -> Int {
        return a - b
    }
}

class GrandChildClass: ChildClass {
    override var d: Int {
        get {
            return 8
        }
    }
    override func calculate(a: Int, b: Int) -> Int {
        return a / b
    }
}

let c: Base1 & Base2 = Child()
print(c.calculate(a: 5, b: 3))
let c1: Base = Child()
print(c1.calculate(a: 5, b: 3))
let cc = ChildClass()
print(cc.calculate(a: 5, b: 3))
print(c.d)
print(cc.d)
let gc = GrandChildClass()
print(gc.calculate(a: 5, b: 3))
print(gc.d)
