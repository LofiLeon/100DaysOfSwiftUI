import Cocoa

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak(){
        print("Woof!")
    }
}

class Cat: Animal {
    func speak(){
        print("Miau!")
    }
}


class Corgi: Dog {
    override func speak() {
        print("Woof! I have a white but!")
    }
}
    
class Poodle: Dog {
    override func speak() {
        print("Woof! I grandma's dog with purple hair!")
    }
}

class Tiger: Cat {
    override func speak() {
        print("I will eat you in one peice")
    }
}

class Persian: Cat {
    override func speak() {
        print("I am soooo sweet...")
    }
}


var edi = Persian(legs: 4)
edi.speak()

    


