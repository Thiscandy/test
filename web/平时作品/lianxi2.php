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
					<li>对部分单元指定键名</li>
					<ul>
						<li>键名用数字会继承</li>
						<li>键名用字符不会继承(字符没加引号会报错)</li>
					</ul>
<pre>
&lt;?php
$array = array(
         "a",
         "b",
    6 => "c",
         "d",
);
var_dump($array);  //array(4) { [0]=> string(1) "a" [1]=> string(1) "b" [6]=> string(1) "c" [7]=> string(1) "d" }
$arr = array(
         "a",
         "b",
    'a' => "c",
         "d",
);
var_dump($arr);    //array(4) { [0]=> string(1) "a" [1]=> string(1) "b" ["a"]=> string(1) "c" [2]=> string(1) "d" }
?>
</pre>
					<li>用方括号语法访问数组单元</li>
<pre>
// 方框号直接访问
&lt;?php
$arrayd = array(
    "foo" => "baa",
    42    => 24,
    "mat" => array(
            "dic" => array(
                "ard" => "for"
            )
        )
);

var_dump($arrayd["foo"]);                //string(3) "baa"
var_dump($arrayd[42]);                   //int(24)
var_dump($arrayd["mat"]["dic"]["ard"]);  //string(3) "for"


// 调用间接访问

function getArray() {
    return array(1, 2, 3);
}

// on PHP 5.4
$secondElement = getArray()[1];
echo $secondElement;             // 2

// previously
$tmp = getArray();
$secondE = $tmp[1];
echo $secondE;                   // 2

// or
list(, $second) = getArray();    // list()把数组中的值赋给对应位的变量
echo $second;                    // 2
?>
</pre>
					<li>用方括号的语法新建 / 修改</li>
<pre>
&lt;?php
$arr = array(5 => 1, 12 => 2);

var_dump($arr);    // array(2) { [5]=> int(1) [12]=> int(2) }

$arr[] = 56;       // 这样的意思相同于 $arr[13] = 56;

var_dump($arr);    // array(3) { [5]=> int(1) [12]=> int(2) [13]=> int(56) }

$arr["x"] = 42;    // 这将添加一个新元素到数组的键"x"

var_dump($arr);    // array(4) { [5]=> int(1) [12]=> int(2) [13]=> int(56) ["x"]=> int(42) }
             
unset($arr[5]);    // unset() 销毁指定的变量。

var_dump($arr);    // array(3) { [12]=> int(2) [13]=> int(56) ["x"]=> int(42) }

unset($arr);       // 这将删除整个数组


// 创建一个简单的数组

$array = array(1, 2, 3, 4, 5);
print_r($array);                  // Array ( [0] => 1 [1] => 2 [2] => 3 [3] => 4 [4] => 5  )

// foreach() 语法结构用于遍历操作或输出数组
// 现在删除其中的所有元素，但保持数组本身不变:

foreach ($array as $i => $value) {
    unset($array[$i]);
}
print_r($array);                  // Array ( )

// 添加一个单元（注意新的键名是 5，而不是你可能以为的 0）

$array[] = 6;
print_r($array);                  // Array ( [5] => 6 )

// array_values() 返回一个包含给定数组中所有键值的数组，键名从 0 开始并以 1 递增。
// 重新索引：

$array = array_values($array);
$array[] = 7;
print_r($array);                  // Array ( [0] => 6 [1] => 7 ) 
?>
</pre>
					<li>数组 函数</li>
					<ul>
						<li>array_change_key_case — 返回字符串键名全为小写或大写的数组</li>
						<li>array_chunk — 将一个数组分割成多个</li>
						<li>array_column — 返回数组中指定的一列</li>
						<li>array_combine — 创建一个数组，用一个数组的值作为其键名，另一个数组的值作为其值</li>
						<li>array_count_values — 统计数组中所有的值出现的次数</li>
						<li>array_diff_assoc — 带索引检查计算数组的差集</li>
						<li>array_diff_key — 使用键名比较计算数组的差集</li>
						<li>array_diff_uassoc — 用用户提供的回调函数做索引检查来计算数组的差集</li>
						<li>array_diff_ukey — 用回调函数对键名比较计算数组的差集</li>
						<li>array_diff — 计算数组的差集</li>
						<li>array_fill_keys — 使用指定的键和值填充数组</li>
						<li>array_fill — 用给定的值填充数组</li>
						<li>array_filter — 用回调函数过滤数组中的单元</li>
						<li>array_flip — 交换数组中的键和值</li>
						<li>array_intersect_assoc — 带索引检查计算数组的交集</li>
						<li>array_intersect_key — 使用键名比较计算数组的交集</li>
						<li>array_intersect_uassoc — 带索引检查计算数组的交集，用回调函数比较索引</li>
						<li>array_intersect_ukey — 用回调函数比较键名来计算数组的交集</li>
						<li>array_intersect — 计算数组的交集</li>
						<li>array_key_exists — 检查给定的键名或索引是否存在于数组中</li>
						<li>array_keys — 返回数组中部分的或所有的键名</li>
						<li>array_map — 为数组的每个元素应用回调函数</li>
						<li>array_merge_recursive — 递归地合并一个或多个数组</li>
						<li>array_merge — 合并一个或多个数组</li>
						<li>array_multisort — 对多个数组或多维数组进行排序</li>
						<li>array_pad — 用值将数组填补到指定长度</li>
						<li>array_pop — 将数组最后一个单元弹出（出栈）</li>
						<li>array_product — 计算数组中所有值的乘积</li>
						<li>array_push — 将一个或多个单元压入数组的末尾（入栈）</li>
						<li>array_rand — 从数组中随机取出一个或多个单元</li>
						<li>array_reduce — 用回调函数迭代地将数组简化为单一的值</li>
						<li>array_replace_recursive — 使用传递的数组递归替换第一个数组的元素</li>
						<li>array_replace — 使用传递的数组替换第一个数组的元素</li>
						<li>array_reverse — 返回一个单元顺序相反的数组</li>
						<li>array_search — 在数组中搜索给定的值，如果成功则返回相应的键名</li>
						<li>array_shift — 将数组开头的单元移出数组</li>
						<li>array_slice — 从数组中取出一段</li>
						<li>array_splice — 把数组中的一部分去掉并用其它值取代</li>
						<li>array_sum — 计算数组中所有值的和</li>
						<li>array_udiff_assoc — 带索引检查计算数组的差集，用回调函数比较数据</li>
						<li>array_udiff_uassoc — 带索引检查计算数组的差集，用回调函数比较数据和索引</li>
						<li>array_udiff — 用回调函数比较数据来计算数组的差集</li>
						<li>array_uintersect_assoc — 带索引检查计算数组的交集，用回调函数比较数据</li>
						<li>array_uintersect_uassoc — 带索引检查计算数组的交集，用回调函数比较数据和索引</li>
						<li>array_uintersect — 计算数组的交集，用回调函数比较数据</li>
						<li>array_unique — 移除数组中重复的值</li>
						<li>array_unshift — 在数组开头插入一个或多个单元</li>
						<li>array_values — 返回数组中所有的值</li>
						<li>array_walk_recursive — 对数组中的每个成员递归地应用用户函数</li>
						<li>array_walk — 使用用户自定义函数对数组中的每个元素做回调处理</li>
						<li>array — 新建一个数组</li>
						<li>arsort — 对数组进行逆向排序并保持索引关系</li>
						<li>asort — 对数组进行排序并保持索引关系</li>
						<li>compact — 建立一个数组，包括变量名和它们的值</li>
						<li>count — 计算数组中的单元数目或对象中的属性个数</li>
						<li>current — 返回数组中的当前单元</li>
						<li>each — 返回数组中当前的键／值对并将数组指针向前移动一步</li>
						<li>end — 将数组的内部指针指向最后一个单元</li>
						<li>extract — 从数组中将变量导入到当前的符号表</li>
						<li>in_array — 检查数组中是否存在某个值</li>
						<li>key_exists — 别名 array_key_exists</li>
						<li>key — 从关联数组中取得键名</li>
						<li>krsort — 对数组按照键名逆向排序</li>
						<li>ksort — 对数组按照键名排序</li>
						<li>list — 把数组中的值赋给一些变量</li>
						<li>natcasesort — 用“自然排序”算法对数组进行不区分大小写字母的排序</li>
						<li>natsort — 用“自然排序”算法对数组排序</li>
						<li>next — 将数组中的内部指针向前移动一位</li>
						<li>pos — current 的别名</li>
						<li>prev — 将数组的内部指针倒回一位</li>
						<li>range — 建立一个包含指定范围单元的数组</li>
						<li>reset — 将数组的内部指针指向第一个单元</li>
						<li>rsort — 对数组逆向排序</li>
						<li>shuffle — 将数组打乱</li>
						<li>sizeof — count 的别名</li>
						<li>sort — 对数组排序</li>
						<li>uasort — 使用用户自定义的比较函数对数组中的值进行排序并保持索引关联</li>
						<li>uksort — 使用用户自定义的比较函数对数组中的键名进行排序</li>
						<li>usort — 使用用户自定义的比较函数对数组中的值进行排序</li>
						<li>foreach — 控制结构是专门用于数组的。它提供了一个简单的方法来遍历数组。</li>
					</ul>
					<?php
						$foo['bar'] = 'enemy';
						// $foo = array('bar' => 'enemy', );
						echo $foo['bar'];
					?>
				</div>
			</div>
		</div>
	</div>
</body>
</html>