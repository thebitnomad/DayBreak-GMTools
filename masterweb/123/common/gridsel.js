/*@@

Copyright (c) Saturn Team. All rights reserved. 

Created_datetime : 2012-05-12 12:30:20

File Name :	common.js

Author : yaoyao

Description :

Change List :

1.create file

@@*/

if (!Ext.grid.GridView.prototype.templates) {
	Ext.grid.GridView.prototype.templates = {};
}
Ext.grid.GridView.prototype.templates.cell = new Ext.Template(
	'<td class="x-grid3-col x-grid3-cell x-grid3-td-{id} x-selectable {css}" style="{style}" tabIndex="0" {cellAttr}>',
	'<div class="x-grid3-cell-inner x-grid3-col-{id}" {attr}>{value}</div>',
	'</td>'
);