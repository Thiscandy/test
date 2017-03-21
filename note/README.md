# 20 Mar 2017

### 利用 Array(n).fill().map(...) 可以方便快速地构造数组：

> Array(10).fill().map((_,i) => i+1); // 得到 [1,2,3,4,5,6,7,8,9,10]

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

考察点:**定时器**、**event loop**、**闭包**

setTimeout()只是将任务添加到任务队列中而已，要等到主执行栈中的代码执行完之后，才会调用定时器中的回调函数。
1. 0
2. 2（闭包，当test执行完成之后，a为2）
3. 3（闭包，第一个定时器执行完之后，修改了a的值为3）

# 21 Mar 2017

### 写一段脚本，实现：当页面上任意一个链接被点击的时候，alert出这个链接在页面上的顺序号，如第一个链接则alert(1), 依次类推；

考察点:**定时器**、**event loop**、**闭包**

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

1. obj.b()：此时this->obj，因此输出：1
2. objb()：由于是在全局作用域调用，this->window，因此输出结果为：2
3. obj.b.call(window)：由于call的作用，this->window，因此输出结果为：2