<%@ page language="C#" autoeventwireup="true" inherits="common_fileupload, App_Web_fileupload.aspx.38131f0b" theme="default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<script type="text/javascript">
		var msgProcessing			= '<%= Resources.StringDef.Processing %>';
		var msgCancelled			= '<%= Resources.StringDef.Cancelled %>';
		var msgStopped				= '<%= Resources.StringDef.Stopped %>';
		var msgSelectLocalFile		= '<%= Resources.StringDef.MsgSelectLocalFile %>';
		var msgUploadedToMaster		= '<%= Resources.StringDef.MsgUploadedToMaster %>';
	</script>
</head>
<head runat="server">
	<link href="../resources/css/swfupload.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../resources/swfupload.js"></script>
	<script type="text/javascript" src="../resources/swfupload.queue.js"></script>
	<script type="text/javascript" src="../resources/swfupload.speed.js"></script>
	<script type="text/javascript" src="../resources/swfuploadhandlers.js"></script>
	<script type="text/javascript">
		var uploadType = 0;					//上传类型(客户端目录/服务器目录)
		var swfu;
		
		window.onload = function () {
			swfu = new SWFUpload( {
				// Backend Settings
				
				upload_url: "upload.aspx?ult=" + uploadType,

				// File Upload Settings
				//file_size_limit : "2 MB",
				//file_types : "*.jpg",
				//file_types_description : "JPG Images",
				file_upload_limit : "0",    // Zero means unlimited

				// Event Handler Settings - these functions as defined in Handlers.js
				//  The handlers are not part of SWFUpload but are part of my website and control how
				//  my website reacts to the SWFUpload events.
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,

				// Button settings
				//button_image_url: "../resources/images/btn.png",
				button_placeholder_id : "spanButtonPlaceholder",
				button_width: 160,
				button_height: 22,
				button_text: '<span class="button">' + msgSelectLocalFile + '</span>',
				button_text_style : '.button { font-size: 12px; text-align:center; }',
				button_text_top_padding: 1,
				button_text_left_padding: 0,
				button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor: SWFUpload.CURSOR.HAND,

				// Flash Settings
				flash_url : "../resources/swfupload.swf",	// Relative to this file

				custom_settings : {
					upload_target: "divFileProgressContainer"
				},

				// Debug Settings
				debug: false
			});
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">
	<div id="content">
		<div id="swfu_container" style="margin: 10px;">
			<div style="display: inline-block; border: solid 1px #7FAAFF; background-color: #C5D9FF; margin-left:5px; height:20px;">
				<span id="spanButtonPlaceholder"></span>
			</div>
			<div id="divFileProgressContainer" style="height: 75px;">
			</div>
		</div>
	</div>
	</form>
</body>
</html>
