/*@@

	Copyright (c) Saturn Team. All rights reserved. 

	Created_datetime : 2012-05-12 10:19:21

	File Name :	common.js

	Author : yaoyao

	Description :

	Change List :

		1.create file

@@*/
function disableFuncKeys( ) {
	/* 屏蔽退格键 F5屏蔽不好使 */
	Ext.fly( document ).addKeyMap( {
		key: Ext.EventObject.BACKSPACE,
		handler: function( source, e ){
			var target = Ext.fly( e.target );
			if ( ( target.is( 'input' ) || target.is( 'input' ) || target.is( 'textarea' ) ) && !target.dom.readOnly )
				return;
			
			e.stopEvent( );
		}
	} );
}

function showErrMsg( title, errMsg, callback ) {
	return Ext.Msg.alert( ).show( {
		title: title,
		msg: errMsg,
		buttons: Ext.Msg.OK,
		minWidth: 300,
		maxWidth: 400,
		icon: Ext.MessageBox.ERROR,
		fn: callback
	} );
}

function showSuccessMsg( title, msg, callback ) {
	return Ext.Msg.alert( ).show( {
		title: title,
		msg: msg,
		buttons: Ext.Msg.OK,
		minWidth: 300,
		maxWidth: 400,
		icon: Ext.MessageBox.INFO,
		fn: callback
	} );
}

function showConfirmMsg( title, errMsg, callback ) {
	Ext.Msg.confirm( title, errMsg, callback );
}

function showPromptMsg( title, msg, callback ) {
	Ext.Msg.prompt( title, msg, callback );
}

function getDateString( date ) {
	return date.getFullYear( ) + "-" + ( date.getMonth( ) + 1 ) + "-" + date.getDate( );
}

function getDateTimeString( time ) {
	return time.format( 'Y-m-d H:i:s' );
}

function htmlencode( str ) {
	if( String( str ).length == 0 ) {
		return '';
	}

	str = String( str ).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/ /g, "&nbsp;").replace(/\'/g, "'").replace(/\"/g, "&quot;");
	return str;
}

function htmldecode( str ) {
	if( String( str ).length == 0 ) {
		return '';
	}

	str = String( str ).replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&nbsp;/g, " ").replace(/'/g, "\'").replace(/&quot;/g, "\"").replace(/&amp;/g, "&");
	return str;
}

function showNotification( msg ) {
	Ext.net.Notification.show( {
		iconCls  : 'icon-information',
		pinEvent : 'click',
		html     : msg,
		title    : msgPrompt
	} );
};

/* 重载applySort解决中文排序问题(默认使用utf8进行排序) */
function storeSortFixedFunc( ) {
	if( this.sortInfo && !this.remoteSort ) {
		var s = this.sortInfo, f = s.field;
		var st = this.fields.get( f ).sortType;
		var fn = function( r1, r2 ) {
			var v1 = st( r1.data[f] ), v2 = st( r2.data[f] );
			//添加:修复汉字排序异常的Bug
			if( typeof( v1 ) == "string" ) {
				//使用localeCompare 比较汉字字符串, Firefox 与 IE 均支持
				return v1.localeCompare(v2);
			}
			return v1 > v2 ? 1 : (v1 < v2 ? -1 : 0);
		};
		this.data.sort( s.direction, fn );
		if( this.snapshot && this.snapshot != this.data ) {
			this.snapshot.sort( s.direction, fn );
		}
	}
};

var setCookie = function( cname, value ) {
	var exdate = new Date( );
	exdate.setDate( exdate.getDate( ) + 30 );
	document.cookie = cname + "=" + escape( value ) + ";expires="+exdate.toGMTString( );
};

var getCookie = function( cname ) {
	if( document.cookie.length > 0 ) {
		var cstart = document.cookie.indexOf( cname + "=" )
		if( cstart != -1 ) {
			cstart = cstart + cname.length + 1;
			
			var cend = document.cookie.indexOf( ";", cstart );
			if( cend == -1 )
				cend = document.cookie.length;
			
			return unescape( document.cookie.substring( cstart, cend ) );
		}
	}
	
	return "";
};

var getSizeText = function(size) {
	if( size == 0 ) {
		return 0;
	}
	if( size < 1024 )
		return size + "Byte";
	else if( size < 1048576 )
		return ( size / 1024 ).toFixed( 2 ) + "KByte";
	else if( size < 1024 * 1024 * 1024 )
		return ( size / ( 1024 * 1024 ) ).toFixed( 2 ) + "MB";
	else	
		return ( size / ( 1024 * 1024 * 1024 ) ).toFixed( 2 ) + "GB";
};

var getSpeedText = function( bps ) {
	if( bps < 1024 )
		return bps + "Byte/s";
	else if( bps < 1048576 )
		return ( bps / 1024 ).toFixed( 2 ) + "KB/s";
	else if( bps < 1024 * 1024 * 1024 )
		return ( bps / ( 1024 * 1024 ) ).toFixed( 2 ) + "MB/s";
	else	
		return ( bps / ( 1024 * 1024 * 1024 ) ).toFixed( 2 ) + "GB/s";
};

var getFileName = function( filePath ) {
	var pathCharIndex = filePath.lastIndexOf( '/' );
	if( pathCharIndex != -1 ) {
		return filePath.substring( pathCharIndex + 1 );
	} else {
		return filePath;
	}
};
