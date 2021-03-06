; CONFIGURATION: simple test function
[
	function? tf: func [data][lest data]
]

;;-----------------------

; string

[ "lest" = tf [ "lest" ] ]

; comment

[ {} = tf [ comment [ b "bold" ] ] ]

; stop

[ {<div>hello</div>} = tf [ div "hello" stop div "world" ] ]

; paired tags

[ {<div>div</div>}				= tf [ div "div" ] ]
[ {<span>span</span>}			= tf [ span "span"] ]
[ {<b>bold</b>}					= tf [ b "bold" ] ]
[ {<i>italic</i>}				= tf [ i "italic" ] ]
[ {<p>para</p>}					= tf [ p "para" ] ]
[ {<p>para^/with newline</p>}	= tf [ p "para^/with newline" ] ]
[ {<p>para</p>}					= tf [ p [ "para" ] ] ]
[ {<p>paragraph</p>}			= tf [ p [ "para" "graph" ] ] ]
[ {<p><b>para</b>graph</p>}		= tf [ p [ b "para" "graph" ] ] ]
[ {<em>em</em>}					= tf [ em "em" ] ]
[ {<strong>strong</strong>}		= tf [ strong "strong" ] ]
[ {<small>Smallprint</small>}	= tf [ small "Smallprint" ] ]
[ {<footer>footer</footer>}		= tf [ footer "footer" ] ]

; unpaired tags

[ {<br>} = tf [ br ] ]
[ {<hr>} = tf [ hr ] ]

; styles (id & class)

[ {<b id="bold-style">bold</b>} = tf [ b #bold-style "bold" ] ]
[ {<b class="bold-style">bold</b>} = tf [ b .bold-style "bold" ] ]
[ {<b class="bold style">bold</b>} = tf [ b .bold .style "bold" ] ]
[ {<b id="bold-text" class="bold style">bold</b>} = tf [ b #bold-text .bold .style "bold" ] ]

; tag nesting

[ {<b><i>bold italic</i></b>} = tf [ b [ i "bold italic" ] ] ]
[ {<b id="bold"><i id="italic">bold italic</i></b>} = tf [ b #bold [ i #italic "bold italic" ] ] ]
[ {<b class="bold"><i id="italic">bold italic</i></b>} = tf [ b .bold [ i #italic "bold italic" ] ] ]
[ {<b id="bold"><i class="italic">bold italic</i></b>} = tf [ b #bold [ i .italic "bold italic" ] ] ]
[ {<b class="bold"><i class="italic">bold italic</i></b>} = tf [ b .bold [ i .italic "bold italic" ] ] ]
[ {<b class="bold style"><i class="italic">bold italic</i></b>} = tf [ b .bold .style [ i .italic "bold italic" ] ] ]
[ {<b class="bold style"><i class="italic style">bold italic</i></b>} = tf [ b .bold .style [ i .italic .style "bold italic" ] ] ]


; SCRIPT tag

[ {<script src="script.js"></script>} = tf [ script %script.js ] ]
[ {<script src="http://iluminat.cz/script.js"></script>} = tf [ script http://iluminat.cz/script.js ] ]
[ {<script src="script.js"></script>} = tf [ script %script.js ] ]
[ {<script type="text/javascript">alert("hello world");</script>} = tf [ script {alert("hello world");} ] ]

; LINK tag

[ {<a href="#">home</a>} = tf [ a %# "home" ] ]
[ {<a href="#">home</a>} = tf [ link %# "home" ] ]
[ {<a href="#about">about</a>} = tf [ link %#about "about" ] ]
[ {<a href="about">about file</a>} = tf [ link %about "about file" ] ]
[ {<a href="http://www.about.at">about web</a>} = tf [ link http://www.about.at "about web" ] ]
[ {<a class="blue" href="#">home</a>} = tf [ link %# .blue "home"] ]
[ {<a id="blue" href="#">home</a>} = tf [ link %# #blue "home"] ]
[ {<a id="blue" class="main" href="#">home</a>} = tf [ link %# #blue .main "home"] ]
[ equal? {<a id="blue" class="main" href="#"><div id="link" class="link-class">home</div></a>}
	tf [
		link %# #blue .main [
			div .link-class #link "home"
		]
	]
]
[ equal? {<div id="outer" class="border"><a id="blue" class="main" href="#"><div id="link" class="link-class">home</div></a></div>}
	tf [
		div #outer .border [
			link %# #blue .main [
				div .link-class #link "home"
			]
		]
	]
]

; IMG tag

[ {<img src="brno.jpg">} = tf [ img %brno.jpg ] ]
[ {<img src="brno.jpg">} = tf [ image %brno.jpg ] ]
[ {<img class="adamov" src="brno.jpg">} = tf [ image %brno.jpg .adamov] ]
[ {<img id="adamov" src="brno.jpg">} = tf [ image #adamov %brno.jpg] ]
[ {<img id="obr" class="adamov" src="brno.jpg">} = tf [ image #obr %brno.jpg .adamov] ]
[ {<img id="obr" class="adamov ivancice" src="brno.jpg">} = tf [ image #obr %brno.jpg .adamov .ivancice ] ]
[ equal?
		{<div id="okraj" class="border small"><img id="obr" class="adamov ivancice" src="brno.jpg"></div>}
		tf [ div .border #okraj .small [image #obr %brno.jpg .adamov .ivancice] ]
]

; LISTS

[ "<ul><li>jedna</li></ul>" = tf [ ul li "jedna" ] ]
[ "<ul><li>jedna</li><li>dva</li></ul>" = tf [ ul li "jedna" li "dva"] ]
[ equal?
	{<ul id="list"><li id="first" class="item">jedna</li><li id="second" class="item">dva</li></ul>}
	tf [ ul #list li .item #first "jedna" li #second .item "dva" ]
]
[ "<ul><li><span>inner element</span></li></ul>" = tf [ ul li [ span "inner element" ] ] ]
[ "<ol><li>jedna</li></ol>" = tf [ ol li "jedna" ] ]
[ "<ol><li>jedna</li><li>dva</li></ol>" = tf [ ol li "jedna" li "dva" ] ]
[ equal?
	{<ol id="list"><li id="first" class="item">jedna</li><li id="second" class="item">dva</li></ol>}
	tf [ ol #list li .item #first "jedna" li #second .item "dva" ]
]
[ equal?
	{<ul><li><ul><li>nested</li><li>this too</li></ul></li><li>back on surface</li></ul>}
	tf [ ul li [ ul li "nested" li "this too" ] li "back on surface" ]
]
[ "<dl><dt>def</dt><dd>val</dd></dl>" = tf [ dl "def" "val" ] ]
[ "<dl><dt>def 1</dt><dd>val 1</dd><dt>def 2</dt><dd>val 2</dd></dl>" = tf [ dl "def 1" "val 1" "def 2" "val 2" ] ]

; HEADINGS

[ {<h1>Brno</h1>} = tf [ h1 "Brno" ] ]
[ {<h2>Brno</h2>} = tf [ h2 "Brno" ] ]
[ {<h3>Brno</h3>} = tf [ h3 "Brno" ] ]
[ {<h4>Brno</h4>} = tf [ h4 "Brno" ] ]
[ {<h5>Brno</h5>} = tf [ h5 "Brno" ] ]
[ {<h6>Brno</h6>} = tf [ h6 "Brno" ] ]
[ {<h1 class="city">Brno</h1>} = tf [ h1 .city "Brno" ] ]
[ {<h2 class="city">Brno</h2>} = tf [ h2 .city "Brno" ] ]
[ {<h3 class="city">Brno</h3>} = tf [ h3 .city "Brno" ] ]
[ {<h4 class="city">Brno</h4>} = tf [ h4 .city "Brno" ] ]
[ {<h5 class="city">Brno</h5>} = tf [ h5 .city "Brno" ] ]
[ {<h6 class="city">Brno</h6>} = tf [ h6 .city "Brno" ] ]
[ {<h1 id="city">Brno</h1>} = tf [ h1 #city "Brno" ] ]
[ {<h2 id="city">Brno</h2>} = tf [ h2 #city "Brno" ] ]
[ {<h3 id="city">Brno</h3>} = tf [ h3 #city "Brno" ] ]
[ {<h4 id="city">Brno</h4>} = tf [ h4 #city "Brno" ] ]
[ {<h5 id="city">Brno</h5>} = tf [ h5 #city "Brno" ] ]
[ {<h6 id="city">Brno</h6>} = tf [ h6 #city "Brno" ] ]

; FORMS

[ equal?
	{<form action="script" method="post" role="form"><div class="form-group"><label for="name">Your name:</label><input class="form-control" type="text" name="name"></div></form>}
	tf [ form %script [ text name "Your name:" ] ]
]
[ equal?
	{<form action="script" method="post" role="form"><div class="form-group"><label for="pass">Password:</label><input class="form-control" type="password" name="pass"></div></form>}
	tf [ form %script [ password pass "Password:" ] ]
]
[ equal?
	{<form action="script" method="post" role="form"><div class="form-group"><label for="mail">Your email:</label><input class="form-control" type="email" name="mail"></div></form>}
	tf [ form %script [ email mail "Your email:" ] ]
]
[ equal?
	{<form action="script" method="post" role="form"><div class="form-group"><label for="name">Your name:</label><input class="form-control" type="text" name="name"></div><div class="form-group"><label for="pass">Password:</label><input class="form-control" type="password" name="pass"></div><div class="form-group"><label for="mail">Your email:</label><input class="form-control" type="email" name="mail"></div></form>}
	tf [
		form %script [
			text name "Your name:"
			password pass "Password:"
			email mail "Your email:"
		]
	]
]
[
	equal?
	{<form action="script" method="post" role="form"><div class="checkbox"><label><input type="checkbox" name="cb1">Check me</label></div></form>}
	tf [ form %script [ checkbox cb1 "Check me" ] ]
]
[
	equal?
	{<form action="script" method="post" role="form"><button type="submit" class="btn btn-default">Bye</button></form>}
	tf [ form %script [ submit "Bye" ] ]
]

; USER tags

[ {<span>nazdar</span>} = tf [ nazdar: [ span "nazdar" ] nazdar ] ]
[ {<div><span>nazdar</span></div>} = tf [ nazdar: [ span "nazdar" ] div [ nazdar ] ] ]
[ {<div><span>nazdar</span></div>} = tf [ nazdar: [ div [ span "nazdar" ] ] nazdar ] ]
[ {<span>ahoj</span>, <span>nazdar</span>!} = tf [ ahoj: [ span "ahoj" ] nazdar: [ span "nazdar" ] ahoj ", " nazdar "!" ] ]

[ {<div class="red">Rebol</div>} = tf [ red-div: value string! [ div .red value ] red-div "Rebol" ] ]
[ {<div class="red"><span>Rebol</span></div>} = tf [ red-div: value block! [ div .red value ] red-div [ span "Rebol" ] ] ]
[ equal?
	{<div class="red"><span id="lang">Rebol</span></div>}
	tf [
		red-div: value block! [ div .red value ]
		lang-span: value string! [ span #lang value ]
		red-div [ lang-span "Rebol" ]
	]
]
[ equal?
	{<div class="red"><span id="lang">Rebol</span></div>}
	tf [
		red-div: value block! [ div .red value ]
		lang-span: value string! [ span #lang value ]
		red-lang: value string! [ red-div [ lang-span value ] ]
		red-lang "Rebol"
	]
]
[ {<span>Hello world</span>} = tf [ greeting: what string! who string! [ span [ what " " who ] ] greeting "Hello" "world" ] ]
[ {<span>Hello world</span>} = tf [ greeting: who string! what string! [ span [ what " " who ] ] greeting "world" "Hello" ] ]
[ equal?
	{<span class="greeting">Hello</span>, <span class="name">world</span>!}
	tf [
		exclamation: ["!"]
		greeting: salute string! name string! [
			span .greeting salute
			", "
			span .name name
			exclamation
		]
		greeting "Hello" "world"
	]
]