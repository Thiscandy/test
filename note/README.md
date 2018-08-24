# 20 Mar 2017

### 利用 Array(n).fill().map(...) 可以方便快速地构造数组：

```javascript

Array(10).fill().map((_,i) => i+1); // 得到 [1,2,3,4,5,6,7,8,9,10]

```

### 下面代码的输出值是

> alert(1&&2)

考察点: `&&` 和 `||` 逻辑运算符运算符
1. 关系表达式的优先级比`&&`和`||`都高
2. 他们不一定都返回布尔值，而是返回运算结果，然后（如果需要）再进行隐性类型转换
3. `&&`如果左运算为真的话，一定会再进行右运算
4. `||`如果左运算为真的话，则停止

因此结果为：2

同样，如果

alert( 1 || 2)

结果为：1

### 输出和输出顺序

```javascript
function test(){
    var a = 1;
    setTimeout(function(){
        alert(a);
        a = 3;
    },1000);
    a = 2;
    setTimeout(function(){
        alert(a);
        a = 4;
    },3000);
}
test();
alert(0);
```

考察点:**定时器**、``event loop``、**闭包**

setTimeout()只是将任务添加到任务队列中而已，要等到主执行栈中的代码执行完之后，才会调用定时器中的回调函数。
> 0
> 2（闭包，当test执行完成之后，a为2）
> 3（闭包，第一个定时器执行完之后，修改了a的值为3）

# 21 Mar 2017

### 写一段脚本，实现：当页面上任意一个链接被点击的时候，alert出这个链接在页面上的顺序号，如第一个链接则alert(1), 依次类推；

考察点:**定时器**、``event loop``、**闭包**

```javascript
window.onload = function(){
    var len = document.links.length;
    for(var i = 0; i < len;i++){
        document.links[i].onclick = (function(i){
            return function(){
                return i+1;
            }
        })(i);
    }
}
```

### 写出下面代码的输出值

```javascript
var obj = {
    a: 1,
    b: function () {console.log(this.a)}
};
var a = 2;
var objb = obj.b;

obj.b();
objb();
obj.b.call(window);
```

考察点：``this``、**全局作用域**、``call``

结果：

> obj.b()：此时this->obj，因此输出：1
> objb()：由于是在全局作用域调用，this->window，因此输出结果为：2
> obj.b.call(window)：由于call的作用，this->window，因此输出结果为：2

# 10 Apr 2017

### replace

stringObject.replace(regexp/substr,replacement)

  regexp/substr 必需。规定子字符串或要替换的模式的 RegExp 对象。
  replacement 必需。一个字符串值。规定了替换文本或生成替换文本的函数。

```javascript

var str = "DAVID IS david David ddavid DAVID IS david David ddavid";
str.replace("David","Dar");

// DAVID IS david Dar ddavid DAVID IS david David ddavid

str.replace(/David/g,"Dar");

// DAVID IS david Dar ddavid DAVID IS david Dar ddavid

str.replace(/David/gi,"Dar");

// Dar IS Dar Dar dDar Dar IS Dar Dar dDar

```

结果：

> replace 方法并不会 替换所有匹配的子串——而仅仅替换第一次匹配
> 正则  全局标志位(/g)
> 正则  大小写(/i)


### Array.sort

```javascript
[
    { name: "He", age: 30 },
    { name: "The", age: 24 },
    { name: "She", age: 28  }
].sort(function(obj1, obj2) {
    // Ascending: first age less than the previous
    // 实现增序排列：前者的 age 小于后者
    return obj1.age - obj2.age;
});
// 返回值:  
// [
//    { name: "The", age: 24 },
//    { name: "She", age: 28 },
//    { name: "He", age: 30 }
// ]
```

### 用``length``属性来截断数组

当数组重新赋值为 [] 时，确实会创建出一个新的空数组，但其它对老数组的引用仍然没变

```javascript
var myArray = yourArray = [1, 2, 3];

myArray = []; // `yourArray` 仍然是 [1, 2, 3]

// 正确的方法是保持引用  
myArray.length = 0;  // `yourArray` 和 `myArray`（以及其它所有对这个数组的引用）都变成 [ ] 了
```

### 用``push``合并数组

简单的原生方法实现数组合

```javascript
var mar = [4,5,6];
var mer = [7,8,9];
Array.prototype.push.apply(mar,mer);
mar; // [4,5,6,7,8,9]
```

# 22 June 2017

### 用``?``代替``if...else``

? 真 : 假，可嵌套

```javascript
const x = 20;

// 正常 if...else 判断

let big;
if ( x > 10 ) { big = true; } else { big = false; }

// 代替后

const big = x > 10 ? true : false;

// 多层嵌套

const big = x > 10 ? '大于 10' : x < 5 ? '小于 5' : '大于 5 小于 10'
```

### 用``||``代替判断变量不是``null``、``undefined``或``空``

```javascript
// 正常判断一个变量不为 null、undefined、空

if (bit !== null || bit !== undefined || bit !=='') {
    let bit2 = bit;
}

// 代替后

const bit2 = bit || 'new';
```

# 12 Jul 2017

### ``undefined``和``null``的区别

``null``表示"**没有对象**",即该处不应该有值

1. 作为函数的参数,表示该函数的参数不是对象
2. 作为对象原型链的终点

```javascript

Object.getPrototypeOf(Object.prototype)

// null

```

``undefined``表示"**缺少值**",就是此处应该有一个值,但是还没有定义

1. 变量被声明了,但没有赋值时,就等于undefined
2. 调用函数时,应该提供的参数没有提供,该参数等于undefined
3. 对象没有赋值的属性,该属性的值为undefined
4. 函数没有返回值时,默认返回undefined

```javascript

var i;
i  //  undefined

function f(x) { console.log(x) }
f()  // undefined

var o =  new Object();
o.p  // undefined

var x = f();
x  //  undefined

```



