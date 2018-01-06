;(function($,window,document,undefined){
	var cssEdit = function(ele,opt){
		this.e = ele;
		this.default = {
			'color':'red',
			'margin':'10px',
			'background-color':'red'
		};
		this.opt = $.extend({},this.default,opt);
	}

	cssEdit.prototype = {
		edit:function(){
			return this.e.css(this.opt);
		}
	}

	$.fn.MyCssEdit = function(opt){
		var cssEdit = new cssEdit(this,opt);
		return cssEdit.edit();
	}

})(jQuery,window,document);