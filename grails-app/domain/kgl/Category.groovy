package kgl

class Category {

    String name
    String label

    static constraints = {
        name size: 5..15, blank: false, unique: true
    }
}
