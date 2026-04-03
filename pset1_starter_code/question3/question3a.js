
let lang = [
    // See annotated reference language in js-synth/languages/simplmaplang.js
    // A few language elements are provided for you.
    // YOUR CODE HERE.
    {
        name: "sin",
        kind: "fun",
        type: "float->float",
        imp: function (x) {
            return Math.sin(x);
        }
    },
    {
        name: "cos",
        kind: "fun",
        type: "float->float",
        imp: function(x) {
            return Math.cos(x);
        } 
    },
    {
        name: "N",
        kind: "int",
        range: [0, 5]
    },
    {
        name: "i2f", // convert int to float – this can be implemented as the identity function
        kind: "fun",
        type: "int->float",
        imp: function (x) {
            return x;
        }
    },
    {
        name: "add",
        kind: "fun",
        type: "float->float->float",
        imp: function(x, y) {
            return x + y;
        }
    },
    {
        name: "subtract",
        kind: "fun",
        type: "float->float->float",
        imp: function(x, y) {
            return x - y;
        }
    },
    {
        name: "divide",
        kind: "fun",
        type: "float->float->float",
        imp: function(x, y) {
            return x/y;
        }
    },
    {
        name: "multiply",
        kind: "fun",
        type: "float->float->float",
        imp: function(x, y) {
            return x * y;
        }
    },
    {
        name: "exp",
        kind: "fun",
        type: "float->float->float",
        imp: function(x, y) {
            return x ** y;
        }
    },
    {
        name: "lt",
        kind: "fun",
        type: "float->float->bool",
        imp: function(x, y) {
            return x < y;
        }
    },
    {
        name: "if",
        kind: "fun",
        type: "bool->float->float->float",
        imp: function(cond, thenVal, elseVal) {
            return cond ? thenVal : elseVal;
        }
    }
]


export { lang };