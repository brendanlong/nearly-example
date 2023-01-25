class And {
    constructor(a, b) {
        this.a = a;
        this.b = b;
    }
}

class Equals {
    constructor(attribute, value) {
        this.attribute = attribute;
        this.value = value;
    }
}

class Or {
    constructor(a, b) {
        this.a = a;
        this.b = b;
    }
}

module.exports = { And, Equals, Or };