package kgl

class UserContact {

    String phone
    String facebookUrl
    String blogUrl
    String lineId
    String skypeId
    String description

    static belongsTo = [user: User]

    static constraints = {
        phone nullable: true
        facebookUrl nullable: true
        blogUrl nullable: true
        lineId nullable: true
        skypeId nullable: true
        description nullable: true, maxSize: 8000
    }
}
