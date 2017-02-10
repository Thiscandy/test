<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>手册练习</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<style>
		.doctable { border-color: #ccc;width:100%;margin: 0 0 1.5rem; }
		.table { border-collapse: collapse;border-spacing: 0; }
	</style>
</head>
<body>
	<!-- main -->
	<div class="container bs-docs-container">
		<div class="row" style="margin:30px 0 60px;">
			<div class="col-md-9" role="main">
				<div class="bs-docs-section">
					<h1>基本语法</h1>
					<ul>
						<li>PHP语句后面要加分号(单行除外)</li>
						<li>纯PHP代码文件可以不用结束符</li>
						<li>可以混杂HTML代码</li>
						<li>使用条件分离</li>
					</ul>
<pre>
&lt;?php
  echo "Hello world";               //Hello world
  echo "&lt;b>可以混杂HTML代码&lt;/b>";    //<b>可以混杂HTML代码</b>
  //单行注释
  #单行注释
  /*多行
    注释*/
?>

&lt;?php if(false): ?>
如果真输出
&lt;?php else: ?>
假输出
&lt;?php endif; ?>

结果：
<?php if(false): ?>
如果真输出
<?php else: ?>
假输出
<?php endif; ?>
</pre>

<?php
/*echo "Hello world";
echo "<br />";
echo "<b>可以混杂HTML代码</b>";
echo "<br />";*/
?>


					<h1>类型</h1>
					<p><code>八种</code>原始数据类型</p>
					<li>
						四种<code>标准量</code>类型
						<ul>
							<li>boolean(布尔型)</li>
							<li>integer(整型)</li>
							<li>float(浮点型)</li>
							<li>string(字符串)</li>
						</ul>
					</li>
					<li>
						两种<code>复合</code>类型
						<ul>
							<li>array(数组)</li>
							<li>object(对象)</li>
						</ul>
					</li>
					<li>
						两种<code>特殊</code>类型
						<ul>
							<li>resource(资源)</li>
							<li>NULL(无类型)</li>
						</ul>
					</li>
					<li>
						<code>伪</code>类型
						<ul>
							<li>mixed(混合类型)</li>
							<li>number(数字类型)</li>
							<li>callback(回调类型)</li>
						</ul>
					</li>

					<h3>查看类型的<code>函数</code></h3>
					<ul>
						<li><code>gettype(变量)</code> 显示变量的类型</li>
						<li><code>var_dump(变量)</code> 显示一个或多个表达式的结构信息，包括表达式的类型与值</li>
						<li><code>is_bool(变量)</code> 判断是否为真,真返回1,假无返回</li>
						<li><code>settype(变量,"类型")</code> 设置变量的类型,成功返回true,失败返回false</li>
					</ul>
<pre>
&lt;?php
  $bool = TRUE;
  $a = array(1,2,array("a","b"));

  echo gettype($bool);               //boolean
  echo var_dump($bool);              //bool(true)
  echo var_dump($a);                 //array(3) { [0]=>int(1) [1]=>int(2) [2]=>array(2) { [0]=>string(1) "a" [1]=>string(1) "b" } }
  echo is_bool($bool);               //1
  echo settype($bool, "int");        //1
  echo var_dump($bool);              //int(1)

?>
</pre>
<?php
	/*$bool = TRUE;
	$a = array(1,2,array("a","b"));

	echo gettype($bool)."<br />";
	echo var_dump($bool);
	echo is_bool($bool)."<br />";
	echo settype($bool, "int")."<br />";
	echo var_dump($bool);
	echo var_dump($a);*/
?>

					<h3>Boolean 布尔类型</h3>
					<p>只有两个关键字<code>true</code>和<code>false</code>,两个都不区分大小写,通常<code>boolean值</code>结果会被传递给<code>控制流程</code>。</p>
<pre>
&lt;?php
  // == 是一个操作符，它检测两个变量是否相等，并返回一个布尔值
  if ($action == "show_version") {
      echo "The version is 1.23";
  }

  // 这样做是不必要的...
  if ($show_separators == TRUE) {
      echo "&lt;hr>\n";
  }

  // ...因为可以使用下面这种简单的方式：
  if ($show_separators) {
      echo "&lt;hr>\n";
  }

  var_dump((bool) "");        // bool(false)
  var_dump((bool) 1);         // bool(true)
  var_dump((bool) -2);        // bool(true)
  var_dump((bool) "foo");     // bool(true)
  var_dump((bool) 2.3e5);     // bool(true)
  var_dump((bool) array(12)); // bool(true)
  var_dump((bool) array());   // bool(false)
  var_dump((bool) "false");   // bool(true)
?>
</pre>
					<h3>Integer 整型</h3>
					<li>整型值可以使用十进制、八进制、十六进制或二进制表示。</li>
<pre>
&lt;?php
$a = 1234; // 十进制数
$a = -123; // 负数
$a = 0123; // 八进制数 (等于十进制 83)
$a = 0x1A; // 十六进制数 (等于十进制 26)
?>
</pre>
					<li>如果给定的一个数<code>超出</code>了 integer 的范围，将会被解释为 <code>float</code>。如果<b>执行的运算结果</b><code>超出</code>了 integer 范围，也会返回 <code>float</code>。</li>
					<li>PHP 中没有整除的运算符。1/2 产生出 float 0.5。值可以舍弃小数部分强制转换为 integer，或者使用 <code>round()</code> 进行四舍五入。</li>
					<ul style="margin-top:5px;">
						<li>round(number,precision,mode) 对浮点数进行四舍五入(详细用法查看教程)</li>
						<li>ceil(number) 函数向上舍入为最接近的整数</li>
						<li>floor(number) 函数向下舍入为最接近的整数</li>
						<li>number_format() 函数通过千位分组来格式化数字(价格化)</li>
					</ul>
					<li>决不要<code>将未知的分数</code>强制转换为 <code>integer</code>，这样有时会导致不可预料的结果。</li>
<pre>
&lt;?php
echo (int) ( (0.1+0.7) * 10 ); // 显示 7!
?>
</pre>

					<h3>Float 浮点型</h3>
					<p>浮点型也叫浮点数float,双精度数double或实数real</p>
					<p>某些数学运算会产生一个由常量NAN代表结果。此结果代表一个在浮点数运算中未定义或不可表述的值。</p>

					<h3>String 字符串</h3>
					<p>在单引号字符串中的变量和特殊字符的转义序列将不会被替换。</p>
<pre>
&lt;?php
echo 'this is a simple string';

// 可以录入多行
echo 'You can also have embedded newlines in 
strings this way as it is
okay to do';

// 输出： Arnold once said: "I'll be back"
echo 'Arnold once said: "I\'ll be back"';

// 输出： You deleted C:\*.*?
echo 'You deleted C:\\*.*?';

// 输出： You deleted C:\*.*?
echo 'You deleted C:\*.*?';

// 输出： This will not expand: \n a newline
echo 'This will not expand: \n a newline';

// 输出： Variables do not $expand $either
echo 'Variables do not $expand $either';
?>
</pre>
					<p>字符串是包围在双引号中，PHP将对一些特殊的字符进行解析</p>
					<table class="doctable table">
						<thead>
							<tr>
								<th>序列</th>
								<th>含义</th>
							</tr>
						</thead>
						<tbody class="tbody">
							<tr>
								<td><em>\n</em></td>
								<td>换行</td>
							</tr>
							<tr>
								<td><em>\r</em></td>
								<td>回车</td>
							</tr>
							<tr>
								<td><em>\t</em></td>
								<td>水平制表符</td>
							</tr>
							<tr>
								<td><em>\v</em></td>
								<td>垂直制表符</td>
							</tr>
							<tr>
								<td><em>\e</em></td>
								<td>Escape</td>
							</tr>
							<tr>
								<td><em>\f</em></td>
								<td>换页</td>
							</tr>
							<tr>
								<td><em>\\</em></td>
								<td>反斜线</td>
							</tr>
							<tr>
								<td><em>\$</em></td>
								<td>美元标记</td>
							</tr>
							<tr>
								<td><em>\"</em></td>
								<td>双引号</td>
							</tr>
						</tbody>
					</table>
<?php
$str = <<<EOD
例子字符串<br/>
跨越多行<br/>
使用定界符 <<< EOD<br/>
 EOD;<br/>
这里的EOD可以随便写。前后对应，符合标识符的命名规则就行。<br/><br/>
EOD;

echo "$str";
?>
<pre>
&lt;?php
/* 含有变量的更复杂示例 */
class foo
{
    var $foo;
    var $bar;

    function foo()
    {
        $this->foo = 'Foo';
        $this->bar = array('Bar1', 'Bar2', 'Bar3');
    }
}

$foo = new foo();
$name = '叶';

echo <<< EOT
我的名字叫 "$name". 我获取到了对象 $foo->foo.&lt;br/>
现在, 显示对象的第二个参数 {$foo->bar[1]}.&lt;br/>
这里显示了一个 'A': \x41&lt;br/>
EOT;
?>

<?php

/* 含有变量的更复杂示例 */
class foo
{
    var $foo;
    var $bar;

    function foo()
    {
        $this->foo = 'Foo';
        $this->bar = array('Bar1', 'Bar2', 'Bar3');
    }
}

$foo = new foo();
$name = '叶';

echo <<< EOT
我的名字叫 "$name". 我获取到了对象 $foo->foo.<br/>
现在, 显示对象的第二个参数 {$foo->bar[1]}.<br/>
这里显示了一个 'A': \x41<br/>
EOT;
?>
</pre>
					<p>public,private,protected 三种类属性的区别</p>
					<ul>
						<li>
							public: 公有属性或方法
							<br/>
							<p>在子类中可以通过self::var 或self::method 来调用,可以通过parent::method来调用父类中的方法,但不能调用公有属性.<br/>在实例中可以通过$obj->var或self::method 来调用</p>
						</li>
						<li>
							protected: 受保护类型
							<br/>
							<p>在子类中可以通过self::var 或self::method调用,　可以通过parent::method来调用父类中的方法<br/>在实例中不能通过$obj->var 来调用  protected类型的方法或属性</p>
						</li>
						<li>
							private: 私有类型
							<p>该类型的属性或方法只能在该类中使用，在该类的实例、子类中、子类的实例中都不能调用私有类型的属性和方法</p>
						</li>
					</ul>
<pre>
&lt;?php

class duixiang {
	public $publicProp='public';
	protected $protected = 'protected';
	private $privateProp = 'private';
}
$prod = new duixiang();
echo $prod->publicProp;    //public

class fotaad {
	public $bar = <<<'EOT'
bareat
EOT;
}
$fotdas = new fotaad();
echo $fotdas->bar;      //bareat

?>
<?php

/*class duixiang {
	public $publicProp='public';
	protected $protected = 'protected';
	private $privateProp = 'private';
}

$prod = new duixiang();
echo $prod->publicProp."<br />";

class fotaad {
	public $bar = <<<'EOT'
bareat
EOT;
}
$fotdas = new fotaad();
echo $fotdas->bar;*/

?>
</pre>
					<p>由于 { 无法被转义，只有 $ 紧挨着 { 时才会被识别。</p>
<pre>
&lt;?php

class foo {
    var $bar = 'I am bar.';
}

$foo = new foo();
$bar = 'bar';
$baz = array('foo', 'bar', 'baz', 'quux');
echo "{$foo->$bar}\n";         //I am bar.
echo "{$foo->$baz[1]}\n";      //I am bar.

?>
<?php

class fat {
    var $bar = 'I am bar.';
}

$foo = new fat();
$bar = 'bar';
$baz = array('foo', 'bar', 'baz', 'quux');
echo "{$foo->$bar}\n";
echo "{$foo->$baz[1]}\n";
?>
</pre>
					<p>只有在该字符串被定义的命名空间中才可以将其值作为变量名来访问。只单一使用花括号 ({}) 无法处理从函数或方法的返回值或者类常量以及类静态变量的值。</p>
					<p>PHP中<code>::</code> 类中 静态方法和静态属性的引用方法</p>
					<ul>
						<li>可以不用实例化对象直接使用 Test::$test 来取得$test属性的值</li>
						<li>静态方法调用也同理Test::test(); 直接调用静态方法test</li>
					</ul>
<pre>
&lt;?php
// 显示所有错误
error_reporting(E_ALL);

class beers {
    const softdrink = 'rootbeer';
    public static $ale = 'ipa';
}

$rootbeer = 'A & W';
$ipa = 'Alexander Keith\'s';

// 有效，输出： I'd like an A & W
echo "I'd like an {${beers::softdrink}}\n";

// 也有效，输出： I'd like an Alexander Keith's
echo "I'd like an {${beers::$ale}}\n";
?>

<?php
// 显示所有错误
error_reporting(E_ALL);

class beers {
    const softdrink = 'rootbeer';
    public static $ale = 'ipa';
}

$rootbeer = 'A & W';
$ipa = 'Alexander Keith\'s';

// 有效，输出： I'd like an A & W
echo "I'd like an {${beers::softdrink}}\n";

// 也有效，输出： I'd like an Alexander Keith's
echo "I'd like an {${beers::$ale}}\n";
?>
</pre>
					<p>获取字符串</p>
<pre>
&lt;?php

// 获取字符串长度
$str = 'This is a test.';
$first = strlen($str);

// 取得字符串的第一个字符
$str = 'This is a test.';
$first = $str[0];

// 取得字符串的第三个字符
$third = $str[2];

// 取得字符串的最后一个字符
$str = 'This is still a test.';
$last = $str[strlen($str)-1]; 

// 修改字符串的最后一个字符
$str = 'Look at the sea';
$str[strlen($str)-1] = 'e';

?>
</pre>
					<p>可以使用<code>ord()</code>和<code>chr()</code>实现ASCII码和字符间的转换</p>
<pre>
&lt;?php

	echo ord("S");
	echo chr("83");
	echo ord("bac");
	echo chr("98");

?>

<?php

	echo ord("S")."<br/>";
	echo chr("83")."<br/>";
	echo ord("bac")."<br/>";
	echo chr("98");

?>
</pre>
					<h3>Array数组</h3>
					<li>定义数组array()</li>
<pre>
&lt;?php

$arraya = array("bar","foo");
$arrayb = array(
	"foo" => "bar",
	"bar" => "foo",
);
$arrayc = [
	"foo" => "bar",
	"bar" => "foo",
];

echo var_dump($arraya);  //array(2) { [0]=> string(3) "bar" [1]=> string(3) "foo" } 
echo var_dump($arrayb);  //array(2) { ["foo"]=> string(3) "bar" ["bar"]=> string(3) "foo" } 
echo var_dump($arrayc);  //array(2) { ["foo"]=> string(3) "bar" ["bar"]=> string(3) "foo" }
?>
</pre>
					<li>类型强制与覆盖</li>
<pre>
&lt;?php

$array = array(
	1    => "a",
	"1"  => "b",
	1.5  => "c",
	true => "d",
);
var_dump($array);    //array(1) { [1]=> string(1) "d" }

?>
</pre>
					<li>混合integer和string</li>
<pre>
&lt;?php
$array = array(
	"for" => "bar",
	"bar" => "for",
	100   => -100,
	-100  => 100,
	"foo" => 101,
	101   => "foo"
);
var_dump($array);    //array(6) { ["for"]=> string(3) "bar" ["bar"]=> string(3) "for" [100]=> int(-100) [-100]=> int(100) ["foo"]=> int(101) [101]=> string(3) "foo" }
?>
</pre>
				</div>
			</div>
		</div>
	</div>
</body>
</html>