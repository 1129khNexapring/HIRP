(function(){return function(){if(!this._is_form){return;}var _a=null;this.on_create=function(){this.set_name("Form_home");this.set_titletext("home");if(Form==this.constructor){this._setFormPosition(1080,720);}_a=new Button("Button00","5","5",null,null,"5","5",null,null,null,null,this);_a.set_taborder("0");_a.set_text("홈화면이지롱");this.addChild(_a.name,_a);_a=new Layout("default","Desktop_screen",1080,720,this,function(_b){});this.addLayout(_a.name,_a);};this.loadPreloadList=function(){};this.on_initEvent=function(){};this.loadIncludeScript("form_home.xfdl");this.loadPreloadList();_a=null;};})();