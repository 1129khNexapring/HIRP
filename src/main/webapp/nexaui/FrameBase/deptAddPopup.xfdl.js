(function(){return function(){if(!this._is_form){return;}var _a=null;this.on_create=function(){this.set_name("deptAddPopup");this.set_titletext("New Form");if(Form==this.constructor){this._setFormPosition(500,350);}_a=new Dataset("ds_color",this);_a._setContents("<ColumnInfo><Column id=\"COLOR_ID\" type=\"STRING\" size=\"256\"/><Column id=\"COLOR_VAL\" type=\"STRING\" size=\"256\"/></ColumnInfo>");this.addChild(_a.name,_a);_a=new Static("static_dept01","59","19","166","41",null,null,null,null,null,null,this);_a.set_taborder("0");_a.set_text("부서 추가");_a.set_font("normal 500 14pt/normal \"Noto Sans KR\"");this.addChild(_a.name,_a);_a=new Static("static_deptInfo","100","70","53","30",null,null,null,null,null,null,this);_a.set_taborder("1");_a.set_text("부서명");_a.set_border("0px none,0px none,1px black");this.addChild(_a.name,_a);_a=new Static("static_deptInfo00","93","120","67","30",null,null,null,null,null,null,this);_a.set_taborder("2");_a.set_text("부서코드");_a.set_border("0px none,0px none,1px black");this.addChild(_a.name,_a);_a=new Static("static_deptInfo01","93","170","67","30",null,null,null,null,null,null,this);_a.set_taborder("3");_a.set_text("부서약어");_a.set_border("0px none,0px none,1px black");this.addChild(_a.name,_a);_a=new Static("static_deptInfo01_00","93","220","67","30",null,null,null,null,null,null,this);_a.set_taborder("4");_a.set_text("부서색상");_a.set_border("0px none,0px none,1px black");this.addChild(_a.name,_a);_a=new Static("static_deptInfo02","93","70","10","30",null,null,null,null,null,null,this);_a.set_taborder("5");_a.set_text("*");_a.set_border("0px none,0px none,1px black");_a.set_color("#ff2323");this.addChild(_a.name,_a);_a=new Edit("edt_deptname","174","70","216","30",null,null,null,null,null,null,this);_a.set_taborder("6");this.addChild(_a.name,_a);_a=new Edit("edt_deptsecond","174","170","216","30",null,null,null,null,null,null,this);_a.set_taborder("7");this.addChild(_a.name,_a);_a=new Button("btn_submit","165","280","80","30",null,null,null,null,null,null,this);_a.set_taborder("8");_a.set_text("저장");_a.set_letterSpacing("0px");_a.set_cssclass("save");this.addChild(_a.name,_a);_a=new Button("btn_cancel","255","280","80","30",null,null,null,null,null,null,this);_a.set_taborder("9");_a.set_text("취소");_a.set_letterSpacing("0px");_a.set_cssclass("cancel");this.addChild(_a.name,_a);_a=new Static("static_msg","174","95","216","30",null,null,null,null,null,null,this);_a.set_taborder("10");_a.set_border("0px none,0px none,1px black");_a.set_font("normal 7pt/normal \"KR\"");_a.set_color("#ff1414");this.addChild(_a.name,_a);_a=new MaskEdit("medt_deptcode","174","120","216","30",null,null,null,null,null,null,this);_a.set_taborder("11");_a.set_textAlign("left");this.addChild(_a.name,_a);_a=new Button("btn_colorchart01","174","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("12");_a.set_background("#FFD8D8");this.addChild(_a.name,_a);_a=new Button("btn_colorchart02","188","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("13");_a.set_background("#FAE0D4");this.addChild(_a.name,_a);_a=new Button("btn_colorchart03","202","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("14");_a.set_background("#FAECC5");this.addChild(_a.name,_a);_a=new Button("btn_colorchart04","216","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("15");_a.set_background("#FAF4C0");this.addChild(_a.name,_a);_a=new Button("btn_colorchart05","230","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("16");_a.set_background("#E4F7BA");this.addChild(_a.name,_a);_a=new Button("btn_colorchart06","244","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("17");_a.set_background("#CEFBC9");this.addChild(_a.name,_a);_a=new Button("btn_colorchart07","258","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("18");_a.set_background("#D4F4FA");this.addChild(_a.name,_a);_a=new Button("btn_colorchart08","272","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("19");_a.set_background("#D9E5FF");this.addChild(_a.name,_a);_a=new Button("btn_colorchart09","286","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("20");_a.set_background("#DAD9FF");this.addChild(_a.name,_a);_a=new Button("btn_colorchart10","300","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("21");_a.set_background("#E8D9FF");this.addChild(_a.name,_a);_a=new Button("btn_colorchart11","314","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("22");_a.set_background("#FFD9FA");this.addChild(_a.name,_a);_a=new Button("btn_colorchart12","328","221","15","15",null,null,null,null,null,null,this);_a.set_taborder("23");_a.set_background("#FFD9EC");this.addChild(_a.name,_a);_a=new Button("btn_colorchart13","174","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("24");_a.set_background("#FFA7A7");this.addChild(_a.name,_a);_a=new Button("btn_colorchart14","188","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("25");_a.set_background("#FFC19E");this.addChild(_a.name,_a);_a=new Button("btn_colorchart15","202","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("26");_a.set_background("#FFE08C");this.addChild(_a.name,_a);_a=new Button("btn_colorchart16","216","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("27");_a.set_background("#FAED7D");this.addChild(_a.name,_a);_a=new Button("btn_colorchart17","230","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("28");_a.set_background("#CEF279");this.addChild(_a.name,_a);_a=new Button("btn_colorchart18","244","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("29");_a.set_background("#B7F0B1");this.addChild(_a.name,_a);_a=new Button("btn_colorchart19","258","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("30");_a.set_background("#B2EBF4");this.addChild(_a.name,_a);_a=new Button("btn_colorchart20","272","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("31");_a.set_background("#B2CCFF");this.addChild(_a.name,_a);_a=new Button("btn_colorchart21","286","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("32");_a.set_background("#B5B2FF");this.addChild(_a.name,_a);_a=new Button("btn_colorchart22","300","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("33");_a.set_background("#D1B2FF");this.addChild(_a.name,_a);_a=new Button("btn_colorchart23","314","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("34");_a.set_background("#FFB2F5");this.addChild(_a.name,_a);_a=new Button("btn_colorchart24","328","235","15","15",null,null,null,null,null,null,this);_a.set_taborder("35");_a.set_background("#FFB2D9");this.addChild(_a.name,_a);_a=new Layout("default","",500,350,this,function(_b){});_a.set_mobileorientation("landscape");this.addLayout(_a.name,_a);};this.loadPreloadList=function(){};this.registerScript("deptAddPopup.xfdl",function(){this.btn_cancel_onclick=function(_a,_b){this.close("cancel");};this.btn_submit_onclick=function(_a,_b){var _c="";var _d=this.edt_deptname.value;var _e="";for(var _h=0;_h<this.ds_color.rowcount;_h++ ){var _f=this.components["btn_color"+_h];var _g=_f.getSelectStatus();if(_g){trace("저장된 컬러:"+_f.background);_e=_f.background;}}if(_d==null||_d.length==0){this.static_msg.set_text("부서 이름을 입력하세요");this.edt_deptname.setFocus();return;}else{_c+=this.edt_deptname.value;_c+=":"+this.medt_deptcode.value;_c+=":"+this.edt_deptsecond.value;_c+=":"+_e;}this.close(_c);};this.edt_deptname_oninput=function(_a,_b){this.static_msg.set_text("");};this.deptAddPopup_onload=function(_a,_b){var _c=this.parent.ds_color;this.ds_color.copyData(_c);var _d=174;var _e=221;for(var _g=0;_g<this.ds_color.rowcount;_g++ ){var _f=new Button("btn_color"+_g,_d,_e,15,15);this.addChild("btn_color"+_g,_f);_f.set_background(this.ds_color.getColumn(_g,"COLOR_VAL"));_f.setEventHandler("onclick",this.btn_color_onclick,this);_f.show();_d+=14;if(_g==11){_d=174;_e+=14;}}};this.btn_color_onclick=function(_a,_b){for(var _e=0;_e<this.ds_color.rowcount;_e++ ){var _c=this.components["btn_color"+_e];var _d=_c.getSelectStatus();if(_d){_c.setSelectStatus(false);_c.set_border("");break;}}_a.setSelectStatus(true);_a.set_border("2px solid red");trace("컬러: "+_a.background);};});this.on_initEvent=function(){this.addEventHandler("onload",this.deptAddPopup_onload,this);this.static_dept01.addEventHandler("onclick",this.static_dept01_onclick,this);this.edt_deptname.addEventHandler("oninput",this.edt_deptname_oninput,this);this.btn_submit.addEventHandler("onclick",this.btn_submit_onclick,this);this.btn_cancel.addEventHandler("onclick",this.btn_cancel_onclick,this);};this.loadIncludeScript("deptAddPopup.xfdl");this.loadPreloadList();_a=null;};})();